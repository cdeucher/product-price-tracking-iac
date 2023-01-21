resource "aws_iam_role" "role_for_apigateway" {
  name               = "${var.project}-apigateway"
  assume_role_policy = file("${path.module}/policies/role.json")
}

resource "aws_iam_policy" "apigateway_logging" {
  name        = "${var.project}-logging"
  description = "IAM policy for logging from a Lambda"

  policy = templatefile("${path.module}/policies/logs_policy.json", {
    log_group_arn  = aws_cloudwatch_log_group.api.arn
    log_filter_arn = aws_cloudwatch_log_group.api.arn
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role_for_apigateway.name
  policy_arn = aws_iam_policy.apigateway_logging.arn
}

#  TODO: remove this policy after testing remove invoke permissions
resource "aws_iam_policy" "api_gateway_access" {
  name        = "${var.project}-gateway-access"
  description = "IAM policy for api_gateway"

  policy = templatefile("${path.module}/policies/apigateway_policy.json", {
    api_arn = aws_api_gateway_rest_api.api.arn
  })
}