resource "aws_api_gateway_rest_api" "api" {
  name = "api"
}

resource "aws_api_gateway_resource" "titles" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "titles"
}

resource "aws_api_gateway_method" "add_title" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.titles.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "add_title" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.titles.id
  http_method             = aws_api_gateway_method.add_title.http_method
  type                    = "AWS_PROXY"
  uri                     = var.invoke_url
  integration_http_method = "POST"
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.add_title_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn    = local.add_title
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  depends_on = [
    aws_api_gateway_method.add_title,
    aws_api_gateway_integration.add_title,
  ]
}

resource "aws_api_gateway_stage" "rest_api_stage" {
  deployment_id = aws_api_gateway_deployment.main.id
  rest_api_id   = aws_api_gateway_rest_api.api.id
  stage_name    = "v1"
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  api_id      = aws_api_gateway_rest_api.api.id
  stage_name  = aws_api_gateway_stage.rest_api_stage.stage_name
  domain_name = aws_api_gateway_domain_name.domain_name.domain_name
}