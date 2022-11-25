locals {
  apigateway_invoke = "arn:aws:execute-api:${var.region}:${var.account_id}:${aws_api_gateway_rest_api.api.id}/*/${aws_api_gateway_method.add_title.http_method}${aws_api_gateway_resource.titles.path}"
}