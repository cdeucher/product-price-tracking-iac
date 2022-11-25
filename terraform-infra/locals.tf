locals {
  get_subdomain = lookup({
        dev = "api-dev.${var.domain}",
        stg = "api-stg.${var.domain}"
    }, var.environment, "api.${var.domain}")
  get_project = "${var.project}-${var.environment}"
}