output "subdomain" {
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