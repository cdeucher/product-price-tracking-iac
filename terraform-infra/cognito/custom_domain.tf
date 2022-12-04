resource "aws_cognito_user_pool_domain" "main" {
  domain          = "login-ze0zatn0ipkhxh56"
  user_pool_id    = aws_cognito_user_pool.user_pool.id
}