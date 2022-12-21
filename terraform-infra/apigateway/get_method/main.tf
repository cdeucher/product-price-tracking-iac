# GET method
resource "aws_api_gateway_method" "method" {
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "GET" # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = aws_api_gateway_method.method.http_method
  type                    = "AWS_PROXY"
  uri                     = var.invoke_url
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "method_get_permission" {
  statement_id            = "AllowExecutionFromAPIGatewayGET"
  action                  = "lambda:InvokeFunction"
  function_name           = var.function_name
  principal               = "apigateway.amazonaws.com"
  source_arn              = local.get_apigateway_invoke
}