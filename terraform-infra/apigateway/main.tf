resource "aws_api_gateway_rest_api" "api" {
  name = "${var.project}-api"
  tags = merge({
    Name = "${var.project}-api"
  },var.tags)
}

resource "aws_api_gateway_account" "gateway_account" {
  cloudwatch_role_arn = aws_iam_role.role_for_apigateway.arn
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = var.endpoint
}

module "authorizer" {
  source = "./auth"

  cognito_user_pool_arn = var.cognito_user_pool_arn
  project               = var.project
  resource_id           = aws_api_gateway_resource.resource.id
  rest_api_id           = aws_api_gateway_rest_api.api.id
  authorizer_cognito_enabled = var.authorizer_cognito_enabled

  depends_on = [aws_api_gateway_rest_api.api]
}

resource "aws_api_gateway_integration" "add_title" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.resource.id
  http_method             = module.authorizer.http_method
  type                    = "AWS_PROXY"
  uri                     = var.invoke_url
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.add_title_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn    = local.apigateway_invoke
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    module.authorizer,
    aws_api_gateway_integration.add_title,
  ]
}

resource "aws_api_gateway_stage" "rest_api_stage" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = var.stage
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.rest_api_stage.stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
}

resource "aws_api_gateway_method_settings" "method_settings" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.rest_api_stage.stage_name
  method_path = "*/*"

  settings {
    data_trace_enabled = true
    metrics_enabled    = true
    logging_level      = "ERROR"  # "INFO"
  }
}