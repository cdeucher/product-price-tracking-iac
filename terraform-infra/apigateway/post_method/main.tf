
resource "aws_api_gateway_authorizer" "api_authorizer" {
    count         = var.authorizer_cognito_enabled ? 1 : 0
    name          = "${var.project}-cognito-authorizer"
    type          = "COGNITO_USER_POOLS"
    rest_api_id   = var.rest_api_id
    provider_arns = [var.cognito_user_pool_arn]
}

resource "aws_api_gateway_method" "method" {
  count         = !var.authorizer_cognito_enabled ? 1 : 0
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "POST" # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "method_authorizer" {
  count         = var.authorizer_cognito_enabled ? 1 : 0
  rest_api_id   = var.rest_api_id
  resource_id   = var.resource_id
  http_method   = "POST" # "POST/GET/PUT/DELETE/OPTIONS/PATCH"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.api_authorizer[0].id
  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "add_title" {
  rest_api_id             = var.rest_api_id
  resource_id             = var.resource_id
  http_method             = local.http_method
  uri                     = var.lambda_invoke_arn
  type                    = "AWS_PROXY"
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "mehotd_post_permission" {
  statement_id            = "AllowExecutionFromAPIGateway"
  action                  = "lambda:InvokeFunction"
  function_name           = var.function_name
  principal               = "apigateway.amazonaws.com"
  source_arn              = local.post_apigateway_invoke
}