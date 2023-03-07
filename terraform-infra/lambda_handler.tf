# TODO: fix policy too much permissive
resource "aws_iam_policy" "sns_access" {
  name        = "${local.get_project}-sns-access"
  description = "IAM policy for sns"
  policy      = templatefile("./policies/sns_policy.json", {})
}

module "lambda_handler" {
  source        = "./lambda"
  src_path      = "../src/lambdas/default"
  function_name = "handler"
  project       = local.get_project
  lambda_env    = [var.lambda_env]
  dynamodb_arn = [module.dynamodb.dynamodb_arn]
  external_policies_arn = [aws_iam_policy.sns_access.arn]
}

module "lambda_scraping" {
  source        = "./lambda"
  src_path      = "../src/lambdas/default"
  function_name = "scraping"
  project       = local.get_project
  dynamodb_stream_arn = [module.dynamodb.dynamodb_stream_arn]
  dynamodb_arn        = [module.dynamodb.dynamodb_arn]
  retry_attempts      = 3
  sqs_stream_arn = [module.queue.queue_arn]
  sqs_arn        = [module.queue.queue_arn]
  external_policies_arn = [aws_iam_policy.sns_access.arn]
  lambda_env     = [merge(var.lambda_env, {
    "QUEUE_NAME" = module.queue.queue_name,
    "QUEUE_URL"  = module.queue.queue_url
  })]
}
