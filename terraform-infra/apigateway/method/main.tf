resource "aws_api_gateway_method" "method" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = var.http_method # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "add_title" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.method.http_method
  type                    = "AWS_PROXY"
  uri                     = var.invoke_url
  integration_http_method = var.http_method
}