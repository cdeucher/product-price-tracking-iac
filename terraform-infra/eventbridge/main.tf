resource "aws_cloudwatch_event_rule" "schedule" {
  name                = "${var.project}-${var.event_name}-schedule"
  description         = "Schedule for Lambda Function"
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "schedule_lambda" {
  count = length(var.lambda_arns) > 0 ? 1 : 0
  rule  = aws_cloudwatch_event_rule.schedule.name
  arn   = var.lambda_arns[count.index]
}

resource "aws_lambda_permission" "allow_events_bridge" {
  count         = length(var.lambda_arns) > 0 ? 1 : 0
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arns[count.index]
  principal     = "events.amazonaws.com"
}