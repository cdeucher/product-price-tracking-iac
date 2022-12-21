output "http_method" {
  value = var.cognito_user_pool_arn != "" ? aws_api_gateway_method.method_authorizer[0].http_method : aws_api_gateway_method.method[0].http_method
}