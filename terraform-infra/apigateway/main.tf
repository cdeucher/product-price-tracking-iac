resource "aws_api_gateway_rest_api" "api" {
  name = "${var.project}-api"
  tags = merge({
    Name = "${var.project}-api"
  },var.tags)
}

resource "aws_api_gateway_account" "gateway_account" {
  cloudwatch_role_arn     = aws_iam_role.role_for_apigateway.arn
}

resource "aws_api_gateway_deployment" "main" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "rest_api_stage" {
  deployment_id           = aws_api_gateway_deployment.main.id
  rest_api_id             = aws_api_gateway_rest_api.api.id
  stage_name              = var.stage
  lifecycle {
    ignore_changes = [deployment_id]
  }
}

resource "aws_api_gateway_base_path_mapping" "path_mapping" {
  api_id                  = aws_api_gateway_rest_api.api.id
  stage_name              = aws_api_gateway_stage.rest_api_stage.stage_name
  domain_name             = aws_api_gateway_domain_name.domain_name.domain_name
}

resource "aws_api_gateway_method_settings" "method_settings" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  stage_name              = aws_api_gateway_stage.rest_api_stage.stage_name
  method_path             = "*/*"

  settings {
    data_trace_enabled = true
    metrics_enabled    = true
    logging_level      = "ERROR"  # "INFO"
  }
}