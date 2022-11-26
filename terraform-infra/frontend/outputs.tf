output "cloudfront" {
  value = aws_cloudfront_distribution.devops_app_cf_distribution.domain_name
}
output "frontend_domain" {
  value = aws_route53_record.www-a.name
}