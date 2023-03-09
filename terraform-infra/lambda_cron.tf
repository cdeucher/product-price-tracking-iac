module "cron" {
  source      = "./eventbridge"
  event_name  = "cron"
  project     = local.get_project
  tags        = var.tags
  lambda_arns = [module.lambda_cron.function_arn]
  schedule    = "rate(1 day)"
}

module "lambda_cron" {
  source         = "./lambda"
  src_path       = "../src/lambdas/default"
  function_name  = "cron"
  project        = local.get_project
  retry_attempts = 3
  dynamodb_arn   = [module.dynamodb.dynamodb_arn]
  sqs_arn        = [module.queue.queue_arn]
  lambda_env     = [merge(local.get_lambda_env, {
      "QUEUE_NAME" = module.queue.queue_name,
      "QUEUE_URL"  = module.queue.queue_url
  })]
}

module "queue" {
  source      = "./sqs"
  queue_name  = "scraper"
  project     = local.get_project
  tags        = var.tags
  lambda_arns = [module.lambda_scraping.function_arn]
}
