locals {
  http_method            = var.cognito_user_pool_arn != "" ? aws_api_gateway_method.method_authorizer[0].http_method : aws_api_gateway_method.method[0].http_method
  post_apigateway_invoke = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.rest_api_id}/*/${local.http_method}${var.resource_path}"
}