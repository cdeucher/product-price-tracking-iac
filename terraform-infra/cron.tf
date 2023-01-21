module "lambda_alert" {
  source         = "./lambda"
  src_path       = "../src/lambdas/filter"
  function_name  = "alert"
  project        = local.get_project
  retry_attempts = 3
  dynamodb_arn   = [module.dynamodb.dynamodb_arn]
  sqs_stream_arn = [module.queue.queue_arn]
  sqs_arn        = [module.queue.queue_arn]
  external_policies_arn = [aws_iam_policy.sns_access.arn]
  lambda_env     = [merge(var.lambda_env, {
    "QUEUE_NAME" = module.queue.queue_name,
    "QUEUE_URL"  = module.queue.queue_url
  })]
}

module "queue" {
  source      = "./sqs"
  queue_name  = "scraper"
  project     = local.get_project
  tags        = var.tags
  lambda_arns = [module.lambda_alert.function_arn]
}

module "lambda_cron" {
  source         = "./lambda"
  src_path       = "../src/lambdas/filter"
  function_name  = "cron"
  project        = local.get_project
  retry_attempts = 3
  dynamodb_arn   = [module.dynamodb.dynamodb_arn]
  sqs_arn        = [module.queue.queue_arn]
  lambda_env     = [merge(var.lambda_env, {
      "QUEUE_NAME" = module.queue.queue_name,
      "QUEUE_URL"  = module.queue.queue_url
  })]
}

module "cron" {
  source      = "./eventbridge"
  event_name  = "cron"
  project     = local.get_project
  tags        = var.tags
  lambda_arns = [module.lambda_cron.function_arn]
  schedule    = "rate(1 day)"
}