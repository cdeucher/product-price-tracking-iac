module "lambda_title" {
  source        = "./lambda"
  src_path      = "../src/lambdas/titles"
  function_name = "titles"
  project       = local.get_project
  lambda_env = [
    merge(var.lambda_env, {
      SUB_LAMBDA = module.lambda_subscription.function_name
    })
  ]
  dynamodb_arn = [module.dynamodb.dynamodb_arn]
  lambda_arn   = [module.lambda_subscription.function_arn]
}

module "lambda_filter" {
  source        = "./lambda"
  src_path      = "../src/lambdas/filter"
  function_name = "filter"
  project       = local.get_project
  lambda_env = [
    merge(var.lambda_env, {
      SUB_LAMBDA = module.lambda_subscription.function_name
    })
  ]
  dynamodb_stream_arn = [module.dynamodb.dynamodb_stream_arn]
  dynamodb_arn        = [module.dynamodb.dynamodb_arn]
  retry_attempts      = 3
}