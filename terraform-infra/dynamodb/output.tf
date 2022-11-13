output "dymanodb_arn" {
  value = aws_dynamodb_table.dbtable.arn
}
output "dymanodb_stream_arn" {
  value = aws_dynamodb_table.dbtable.stream_arn
}