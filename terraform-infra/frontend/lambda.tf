# TODO move to a separate file
resource "aws_iam_role" "lambda_edge_exec" {
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

data "archive_file" "lambda_edge_origin_response_zip" {
  type        = "zip"
  output_path = "${path.module}/src/lambdas/lambda_edge_origin_response.zip"
  source_dir  = "${path.module}/src/lambdas/lambda_edge_origin_response/"
}

resource "aws_lambda_function" "lambda_edge_origin_response" {
  function_name = "devops_app-app-edge-origin-response-${var.env_name}"
  role          = aws_iam_role.lambda_edge_exec.arn
  publish       = true

  handler          = "lambda.handler"
  filename         = data.archive_file.lambda_edge_origin_response_zip.output_path
  source_code_hash = data.archive_file.lambda_edge_origin_response_zip.output_base64sha256

  runtime = "nodejs14.x"

  tags = merge({ Name  = "devops_app-${var.env_name}" }, var.tags)
}
