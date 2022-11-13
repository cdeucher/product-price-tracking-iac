data "aws_route53_zone" "zone" {
  name = var.domain
}

resource "aws_acm_certificate" "certificate" {
  domain_name       = var.sub_domain
  validation_method = "DNS"
}
resource "aws_route53_record" "certificate_validation" {
  name    = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_type
  zone_id = data.aws_route53_zone.zone.zone_id
  records = [tolist(aws_acm_certificate.certificate.domain_validation_options)[0].resource_record_value]
  ttl     = 60
}
resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [aws_route53_record.certificate_validation.fqdn]
}
resource "aws_api_gateway_domain_name" "domain_name" {
  domain_name              = var.sub_domain
  regional_certificate_arn = aws_acm_certificate_validation.certificate_validation.certificate_arn
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "sub_domain" {
  name    = aws_api_gateway_domain_name.domain_name.domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.zone.zone_id

  alias {
    name                   = aws_api_gateway_domain_name.domain_name.regional_domain_name
    zone_id                = aws_api_gateway_domain_name.domain_name.regional_zone_id
    evaluate_target_health = false
  }
}