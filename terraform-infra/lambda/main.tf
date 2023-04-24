data "archive_file" "code" {
  type        = "zip"
  source_dir  = "${var.src_path}/src"
  output_path = "outputs/${var.function_name}-src.zip"
}
data "archive_file" "layer" {
  type        = "zip"
  source_dir  = "${var.src_path}/layer"
  output_path = "outputs/${var.function_name}-layer.zip"
}
resource "aws_lambda_layer_version" "this" {
  filename                 = "outputs/${var.function_name}-layer.zip"
  layer_name               = "${var.project}-${var.function_name}-layer"
  description              = "${var.project}-${var.function_name}-layer"
  source_code_hash         = data.archive_file.layer.output_base64sha256
  compatible_runtimes      = ["python3.8"]
  compatible_architectures = ["x86_64"]
}

module "lambda" {
  source        = "./function"
  function_name = var.function_name
  project       = var.project
  role_arn      = aws_iam_role.role_for_lambda.arn
  lambda_env    = var.lambda_env
  layer_arn     = aws_lambda_layer_version.this.arn
  output_path   = data.archive_file.code.output_path
  output_base64sha256 = data.archive_file.code.output_base64sha256
  image_uri     = var.image_uri
}

resource "aws_lambda_event_source_mapping" "events_triggering_lambda" {
  count                  = length(var.dynamodb_stream_arn) > 0 ? 1 : 0
  event_source_arn       = var.dynamodb_stream_arn[count.index]
  function_name          = module.lambda.lambda_arn
  starting_position      = "LATEST"
  batch_size             = 1
  maximum_retry_attempts = var.retry_attempts

  # @TODO: Add support for filter parameters
  dynamic "filter_criteria" {
    for_each = var.filter_criteria != "" ? [var.filter_criteria] : []
    content {
      filter {
        pattern = jsonencode({
          "eventName" : [filter_criteria.value]
        })
      }
    }
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  count            = length(var.sqs_stream_arn) > 0 ? 1 : 0
  batch_size       = 1
  event_source_arn = var.sqs_stream_arn[count.index]
  enabled          = true
  function_name    = module.lambda.lambda_arn
}
