locals {
  s3_origin_id = "devops-app-cf-origin-${aws_s3_bucket.devops_app_bucket.bucket_domain_name}"
  domain_name  = lookup({ prd = "cabd.link" }, var.env_name, "cabd.link")
}