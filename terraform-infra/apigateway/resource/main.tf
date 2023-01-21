resource "aws_api_gateway_resource" "resource" {
  rest_api_id = var.rest_api_id
  parent_id   = var.root_resource_id
  path_part   = var.endpoint
}