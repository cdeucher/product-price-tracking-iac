module "dynamodb" {
  source     = "./dynamodb"
  table_name = var.tabe_name
  attributes = var.dynamodb_attributes
  dynamodb_hash_key = var.dynamodb_hash_key
  dynamodb_range_key = var.dynamodb_range_key
}

module "cognito" {
  source                        = "./cognito"
  project                       = local.get_project
  cognito_user_pool_name        = var.cognito_user_pool_name
  cognito_user_pool_client_name = var.cognito_user_pool_client_name
  domain_callback_url           = local.auth_callback_url
  gcp_client_id                 = var.gcp_client_id
  gcp_client_secret             = var.gcp_client_secret
  domain                        = var.domain
}

module "frontend" {
  source                 = "./frontend"
  service_account_ci_arn = var.service_account_ci_arn
  env_name               = var.environment
  tags                   = var.tags
  aws_region             = var.region
  src_path               = "../../src/frontend"
  project                = local.get_project
  subdomain              = "dash"
  domain_name            = local.domain_name
}

module "grafana" {
  source = "./grafana"
  project = local.get_project
  external_id = var.grafana_external_id
  grafana_account_id = var.grafana_account_id
}
