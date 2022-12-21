output "rest_api_url" {
  value = "${aws_api_gateway_deployment.main.invoke_url}${aws_api_gateway_stage.rest_api_stage.stage_name}"
}
output "invoke_url" {
  value = "https://${aws_api_gateway_domain_name.domain_name.domain_name}"
}
output "rest_api_arn" {
  value = aws_api_gateway_rest_api.api.arn
}
output "rest_api_id" {
  value = aws_api_gateway_rest_api.api.id
}
output "root_resource_id" {
  value = aws_api_gateway_rest_api.api.root_resource_id
}