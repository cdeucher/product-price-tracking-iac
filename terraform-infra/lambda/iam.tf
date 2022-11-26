resource "aws_iam_role" "role_for_lambda" {
    name = "${var.project}-role-${var.function_name}"
    assume_role_policy = file("${path.module}/policies/role.json")
}

resource "aws_iam_policy" "policy" {
    name        = "${var.project}-${var.function_name}-policy-logs"
    description = "IAM policy for logging from a Lambda"

    policy = templatefile("${path.module}/policies/logs_policy.json",{
      log_group_arn = aws_cloudwatch_log_group.log_group.arn
    })
}

#  TODO: fix permissions to allow only the lambda to write to the log group
resource "aws_iam_role_policy_attachment" "lambda_logs" {
    role       = aws_iam_role.role_for_lambda.name
    policy_arn = aws_iam_policy.policy.arn
}

#  TODO: remove this policy after testing remove invoke permissions
resource "aws_iam_role_policy_attachment" "lambda_policy" {
    role       = aws_iam_role.role_for_lambda.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "dynamodb_access" {
    count = length(concat(var.dynamodb_arn,var.dymanodb_stream_arn)) > 0 ? 1 : 0
    name        = "${var.project}-${var.function_name}-dynamodb-access"
    description = "IAM policy for Dynamodb"

    policy = templatefile("${path.module}/policies/dynamodb_policy.json",{
        arns = concat(var.dynamodb_arn,var.dymanodb_stream_arn)
    })
}

resource "aws_iam_role_policy_attachment" "dynamodb_access" {
    count = length(concat(var.dynamodb_arn,var.dymanodb_stream_arn)) > 0 ? 1 : 0
    role       = aws_iam_role.role_for_lambda.name
    policy_arn = aws_iam_policy.dynamodb_access[0].arn
}
