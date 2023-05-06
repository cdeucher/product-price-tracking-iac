output "role_arn" {
  value       = aws_iam_role.grafana_labs_cloudwatch_integration.arn
  description = "The ARN for the role created, copy this into Grafana Cloud installation."
}
