resource "aws_cloudwatch_log_group" "api" {
  name              = "${var.project}/${aws_api_gateway_rest_api.api.id}/${aws_api_gateway_stage.rest_api_stage.stage_name}"
  retention_in_days = 7
}