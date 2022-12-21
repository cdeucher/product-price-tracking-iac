output "topic_name" {
  value = aws_sns_topic.topic.name
}
output "subscription_arns" {
  value = aws_sns_topic_subscription.lambda_subscription
}
output "topic_arn" {
  value = aws_sns_topic.topic.arn
}