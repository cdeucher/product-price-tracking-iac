
resource "aws_api_gateway_authorizer" "api_authorizer" {
    count         = var.cognito_user_pool_arn != "" ? 1 : 0
    name          = "${var.project}-cognito-authorizer"
    type          = "COGNITO_USER_POOLS"
    rest_api_id   = var.rest_api_id
    provider_arns = [var.cognito_user_pool_arn]
}

resource "aws_api_gateway_method" "method" {
  count         = var.cognito_user_pool_arn != "" ? 0 : 1
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "POST" # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "method_authorizer" {
  count         = var.cognito_user_pool_arn != "" ? 1 : 0
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "POST" # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api_authorizer[0].id
  request_parameters = {
    "method.request.path.proxy" = true
  }
}