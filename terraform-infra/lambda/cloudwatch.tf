resource "aws_cloudwatch_log_group" "log_group" {
  name              = "${var.project}/${aws_lambda_function.lambda.function_name}"
  retention_in_days = 1
}