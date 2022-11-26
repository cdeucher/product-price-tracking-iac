output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.user_pool.id
}

output "cognito_user_pool_arn" {
  value = aws_cognito_user_pool.user_pool.arn
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.user_pool_client.id
}

output "aws_cognito_identity_pool_id" {
  value = aws_cognito_identity_pool.main.id
}

output "aws_cognito_login_domain" {
  value = aws_cognito_user_pool_domain.main.domain
}