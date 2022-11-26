output "api" {
  description = "main_url da api"
  value       = local.get_subdomain
}
output "Endpoint" {
  description = "Endpoint to invoke api"
  value       = module.apigateway.invoke_url
}
output "rest_api_url" {
  value = module.apigateway.rest_api_url
}

output "cognito_client_id" {
  value = module.cognito.user_pool_client_id
}

output "cognito_pool_id" {
  value = module.cognito.cognito_user_pool_id
}

output "cognito_identity_pool_id" {
  value = module.cognito.aws_cognito_identity_pool_id
}

output "frontend_domain" {
  value = module.frontend.frontend_domain
}

output "aws_cognito_login_domain" {
  value = module.cognito.aws_cognito_login_domain
}