resource "aws_iam_role" "role_for_apigateway" {
  name = "role_for_apigateway"

  assume_role_policy = templatefile("./apigateway/policies/role.json", {})
}

resource "aws_iam_policy" "apigateway_logging" {
  name        = "apigateway_logging"
  description = "IAM policy for logging from a Lambda"

  policy = templatefile("./apigateway/policies/logs_policy.json",{
    log_group_arn = aws_cloudwatch_log_group.api.arn
    log_filter_arn = aws_cloudwatch_log_group.api.arn
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role_for_apigateway.name
  policy_arn = aws_iam_policy.apigateway_logging.arn
}