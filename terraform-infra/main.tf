module "dynamodb" {
  source = "./dynamodb"
  table_name = var.tabe_name
  attributes = var.dynamodb_attributes
}

module "lambda" {
  source = "./lambda"
  tabe_name    = var.tabe_name
  dynamodb_arn = module.dynamodb.dymanodb_arn
  dymanodb_stream_arn = module.dynamodb.dymanodb_stream_arn
}

module "apigateway" {
  source = "./apigateway"

  invoke_url                    = module.lambda.lambda_add_title_invokearn
  add_title_function_name       = module.lambda.add_title_function_name
  account_id                    = var.accountId
  region                        = var.region
  sub_domain                    = local.get_subdomain
  domain                        = var.domain
}