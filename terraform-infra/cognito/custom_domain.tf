resource "random_string" "random" {
  length           = 16
  special          = false
  upper            = false
  override_special = "/@£$"
}

resource "aws_cognito_user_pool_domain" "main" {
  domain          = "login-${random_string.random.result}"
  user_pool_id    = aws_cognito_user_pool.user_pool.id
}