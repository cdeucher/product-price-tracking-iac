locals {
  domain_name = lookup({ prd = var.domain }, var.environment, var.domain)
  get_subdomain = lookup({
    dev = "api-dev.${local.domain_name}",
    stg = "api-stg.${local.domain_name}"
  }, var.environment, "api.${local.domain_name}")
  get_project       = "${var.project}-${var.environment}"
  auth_callback_url = "https://dash.${local.domain_name}"
}