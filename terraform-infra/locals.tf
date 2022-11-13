locals {
  get_subdomain = lookup({
        dev = "api-dev.${var.domain}",
        stg = "api-stg.${var.domain}"
    }, var.env_name, "api.${var.domain}")
}