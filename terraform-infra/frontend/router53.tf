data "aws_route53_zone" "zone" {
  name = var.domain_name
}

resource "aws_route53_record" "www-a" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name    = local.get_domain
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.devops_app_cf_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.devops_app_cf_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
