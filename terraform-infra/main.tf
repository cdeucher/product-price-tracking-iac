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
    lambda_env          = var.lambda_env
    dymanodb_stream_arn = [module.dynamodb.dymanodb_stream_arn]
    dynamodb_arn        = [module.dynamodb.dymanodb_arn]
}

module "lambda_subscription" {
    source              = "./lambda"
    src_path            = "../src/lambdas/filter" # same as filter
    function_name       = "subscription"
    project             = local.get_project
}

module "cognito" {
    source = "./cognito"
    project                       = local.get_project
    cognito_user_pool_name        = var.cognito_user_pool_name
    cognito_user_pool_client_name = var.cognito_user_pool_client_name
    domain_callback_url           = local.auth_callback_url
    gcp_client_id                 = var.gcp_client_id
    gcp_client_secret             = var.gcp_client_secret
    domain                        = var.domain
}

module "subscription" {
    source          = "./sns"
    project         = local.get_project
    tags            = var.tags
}

module "frontend" {
    source     = "./frontend"
    service_account_ci_arn = var.service_account_ci_arn
    env_name   = var.environment
    tags       = var.tags
    aws_region = var.region
    src_path   = "../../src/frontend"
    project    = local.get_project
    subdomain  = "dash"
    domain_name= local.domain_name
}