locals {
  s3_origin_id = "devops-app-cf-origin-${aws_s3_bucket.devops_app_bucket.bucket_domain_name}"
  get_domain = "${var.subdomain}.${var.domain_name}"
}