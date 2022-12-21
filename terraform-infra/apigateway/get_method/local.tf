locals {
  get_apigateway_invoke = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/${aws_api_gateway_method.method.http_method}${var.resource_path}"
}