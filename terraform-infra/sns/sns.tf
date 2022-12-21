resource "aws_sns_topic" "topic" {
  name            = "${local.get_name}-topic"
  delivery_policy = file("${path.module}/policies/delivery.json")
  tags = merge({
    Name = "${local.get_name}-topic"
  }, var.tags)
}

resource "aws_sns_topic_subscription" "lambda_subscription" {
  count     = length(var.lambdas)
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "lambda"
  endpoint  = var.lambdas[count.index].lambda_arn
}

resource "aws_lambda_permission" "policy" {
  count         = length(var.lambdas) > 0 ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = var.lambdas[count.index].function_name
  principal     = "sns.amazonaws.com"
  statement_id  = "AllowSubscriptionToSNS"
  source_arn    = aws_sns_topic.topic.arn
}