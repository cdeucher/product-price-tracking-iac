output "dynamodb_arn" {
  value = aws_dynamodb_table.dbtable.arn
}
output "dynamodb_stream_arn" {
  value = aws_dynamodb_table.dbtable.stream_arn
}