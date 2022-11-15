data "archive_file" "code" {
  for_each    = toset(["titles","filter"])
  type        = "zip"
  # source_file = "../lambdas/${each.key}/${each.key}.py"
  source_dir = "../lambdas/${each.key}"
  output_path = "outputs/${each.key}.zip"
}

resource "aws_lambda_function" "add_title" {
  function_name    = "api_addtitle"
  role             = aws_iam_role.role_for_lambda.arn
  runtime          = "python3.8"
  filename         = data.archive_file.code["titles"].output_path
  handler          = "titles.handle_addtitle"
  source_code_hash = data.archive_file.code["titles"].output_base64sha256
  publish          = true
  environment {
    variables = {
      TITLES_TABLE = var.tabe_name
    }
  }
}

resource "aws_lambda_function" "exec_filter" {
  function_name    = "exec_filter"
  role             = aws_iam_role.role_for_lambda.arn
  runtime          = "python3.8"
  filename         = data.archive_file.code["filter"].output_path
  handler          = "filter.exec_filter"
  source_code_hash = data.archive_file.code["filter"].output_base64sha256
  publish          = true
}

# every new entry in the table will trigger the lambda
resource "aws_lambda_event_source_mapping" "allow_dynamodb_table_to_trigger_lambda" {
  event_source_arn  = var.dymanodb_stream_arn
  function_name     = aws_lambda_function.exec_filter.arn
  starting_position = "LATEST"
  batch_size = 1
}

resource "aws_cloudwatch_log_group" "add_title" {
  name              = "/aws/lambda/${aws_lambda_function.add_title.function_name}"
  retention_in_days = 1
}
resource "aws_cloudwatch_log_group" "exec_filter" {
  name              = "/aws/lambda/${aws_lambda_function.exec_filter.function_name}"
  retention_in_days = 1
}