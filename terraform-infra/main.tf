module "dynamodb" {
  source      = "./dynamodb"
  table_name  = var.tabe_name
  attributes  = var.dynamodb_attributes
}

module "lambda_title" {
  source              = "./lambda"
  src_path            = "../src/lambdas/titles"
  function_name       = "titles"
  project             = local.get_project
  lambda_env          = var.lambda_env
  dynamodb_arn        = [module.dynamodb.dymanodb_arn]
}

module "lambda_filter" {
  source              = "./lambda"
  src_path            = "../src/lambdas/filter"
  function_name       = "filter"
  project             = local.get_project
  dymanodb_stream_arn = [module.dynamodb.dymanodb_stream_arn]
}

module "cognito" {
    count = var.cognito_enabled ? 1 : 0
    source = "./cognito"
    cognito_user_pool_name        = var.cognito_user_pool_name
    cognito_user_pool_client_name = var.cognito_user_pool_client_name
}

module "apigateway" {
  source = "./apigateway"

  project                       = local.get_project
  endpoint                      = "api2"
  stage                         = "dev"
  invoke_url                    = module.lambda_title.invoke_arn
  add_title_function_name       = module.lambda_title.function_name
  account_id                    = var.accountId
  region                        = var.region
  sub_domain                    = local.get_subdomain
  domain                        = var.domain
  tags                          = var.tags
  cognito_user_pool_arn         = var.cognito_enabled ? module.cognito[0].cognito_user_pool_arn : ""
}

module "frontend" {
  source     = "./frontend"
  env_name   = var.environment
  tags       = var.tags
  aws_region = var.region
  src_path   = "../src/frontend"
}