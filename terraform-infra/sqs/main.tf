resource "aws_sqs_queue" "queue" {
  name                        = "${var.project}-${var.queue_name}"
  fifo_queue                  = false
  content_based_deduplication = false
  delay_seconds               = 90
  max_message_size            = 2048
  message_retention_seconds   = 86400
  receive_wait_time_seconds   = 10
  visibility_timeout_seconds  = 300
}

resource "aws_lambda_permission" "policy" {
  count         = length(var.lambda_arns) > 0 ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_arns[count.index]
  principal     = "sqs.amazonaws.com"
  statement_id  = "AllowSubscriptionToSQS"
  source_arn    = aws_sqs_queue.queue.arn
}