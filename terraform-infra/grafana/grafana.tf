data "aws_iam_policy_document" "trust_grafana" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.grafana_account_id}:root"]
    }
    actions = ["sts:AssumeRole"]
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.external_id]
    }
  }
}
resource "aws_iam_role" "grafana_labs_cloudwatch_integration" {
  name        = "${var.project}-grafana"
  description = "Role used by Grafana CloudWatch integration."
  assume_role_policy = data.aws_iam_policy_document.trust_grafana.json
  inline_policy {
    name = "${var.project}-grafana"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = [
            "tag:GetResources",
            "cloudwatch:GetMetricData",
            "cloudwatch:GetMetricStatistics",
            "cloudwatch:ListMetrics"
          ]
          Resource = "*"
        }
      ]
    })
  }
}
