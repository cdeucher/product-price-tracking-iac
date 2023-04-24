resource "aws_ecr_repository" "scraping" {
  name                 = "${local.get_project}-scraping"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
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
  repository_arn = [aws_ecr_repository.scraping.arn]
  image_uri = [aws_ecr_repository.scraping.repository_url]
  lambda_env     = [merge(local.get_lambda_env, {
    "QUEUE_NAME" = module.queue.queue_name,
    "QUEUE_URL"  = module.queue.queue_url
  })]
}
