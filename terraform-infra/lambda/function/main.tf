resource "aws_lambda_function" "code" {
  count = length(var.image_uri) > 0 ? 0 : 1
  function_name    = "${var.project}-${var.function_name}"
  role             = var.role_arn
  runtime          = "python3.8"
  layers           = [var.layer_arn]
  handler          = "app.handler"
  filename         = var.output_path
  source_code_hash = var.output_base64sha256
  publish          = true
  timeout          = 300
  memory_size      = 256
  dynamic "environment" {
    for_each = length(var.lambda_env) > 0 ? var.lambda_env : []
    content {
      variables = environment.value
    }
  }
  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}
resource "aws_lambda_function" "uri" {
  count = length(var.image_uri) > 0 ? 1 : 0
  function_name    = "${var.project}-${var.function_name}"
  role             = var.role_arn
  runtime          = "python3.8"
  handler          = "app.handler"
  image_uri        = "${var.image_uri[count.index]}:latest"
  package_type     = "Image"
  publish          = true
  timeout          = 300
  memory_size      = 1024
  dynamic "environment" {
    for_each = length(var.lambda_env) > 0 ? var.lambda_env : []
    content {
      variables = environment.value
    }
  }
  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}
