resource "aws_cognito_user_pool" "user_pool" {
  name = var.cognito_user_pool_name
  username_configuration {
    case_sensitive = false
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                = var.cognito_user_pool_client_name
  user_pool_id        = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
}