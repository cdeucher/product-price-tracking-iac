resource "aws_iam_role" "role_for_lambda" {
  name = "role_for_lambda"

  assume_role_policy = templatefile("./lambda/policies/role.json", {})
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  description = "IAM policy for logging from a Lambda"

  policy = templatefile("./lambda/policies/logs_policy.json",{
    log_group_arn = aws_cloudwatch_log_group.add_title.arn
    log_filter_arn = aws_cloudwatch_log_group.exec_filter.arn
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.role_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

resource "aws_iam_policy" "dynamodb_access" {
  name        = "dynamodb_access"
  description = "IAM policy for Dynamodb"

  policy = templatefile("./lambda/policies/dynamodb_policy.json",{
    dynamodb_arn = var.dynamodb_arn
    dymanodb_stream_arn = var.dymanodb_stream_arn
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
  role       = aws_iam_role.role_for_lambda.name
  policy_arn = aws_iam_policy.dynamodb_access.arn
}


resource "aws_iam_policy" "api_gateway_access" {
  name        = "api_gateway_access"
  description = "IAM policy for api_gateway"

  policy = templatefile("./lambda/policies/apigateway_policy.json",{
    api_arn = var.api_arn
  })
}

