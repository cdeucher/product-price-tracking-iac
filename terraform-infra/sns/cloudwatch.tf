resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/sns/${local.get_name}"
  retention_in_days = 7
  tags = merge({
    Name = "/aws/sns/${local.get_name}"
  },var.tags)
}