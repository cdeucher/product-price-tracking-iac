resource "aws_cognito_user_pool_client" "user_pool_client" {
  name                                 = var.cognito_user_pool_client_name
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  explicit_auth_flows                  = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
  callback_urls                        = [var.domain_callback_url]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_scopes                 = ["email", "openid", "phone"]
  supported_identity_providers         = ["Google"] #["COGNITO", "Google"]

}

resource "aws_cognito_identity_provider" "provider" {
  user_pool_id  = aws_cognito_user_pool.user_pool.id
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = var.gcp_client_id
    client_secret    = var.gcp_client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}

resource "aws_cognito_identity_pool" "main" {
  identity_pool_name               = "${var.project}-identity-pool"
  allow_unauthenticated_identities = false

  supported_login_providers = {
    "accounts.google.com" = var.gcp_client_id
  }
}

resource "aws_cognito_identity_pool_roles_attachment" "main" {
  identity_pool_id = aws_cognito_identity_pool.main.id
  roles = {
    authenticated   = aws_iam_role.auth_iam_role.arn
    unauthenticated = aws_iam_role.unauth_iam_role.arn
  }
}
# TODO: move roles to IAM file and JSON policy
resource "aws_iam_role" "auth_iam_role" {
  name               = "${var.project}-auth-iam-role"
  assume_role_policy = <<EOF
 {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "cognito-identity.amazonaws.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "cognito-identity.amazonaws.com:aud": "${aws_cognito_identity_pool.main.id}"
                },
                "ForAnyValue:StringLike": {
                    "cognito-identity.amazonaws.com:amr": "authenticated"
                }
            }
        }
    ]
 }
 EOF
}

resource "aws_iam_role" "unauth_iam_role" {
  name               = "${var.project}-unauth-iam-role"
  assume_role_policy = <<EOF
 {
      "Version": "2012-10-17",
      "Statement": [
           {
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Principal": {
                     "Federated": "cognito-identity.amazonaws.com"
                },
                "Effect": "Allow",
                "Sid": ""
           }
      ]
 }
 EOF
}

resource "aws_iam_role_policy" "web_iam_unauth_role_policy" {
  name = "${var.project}-web-iam-unauth-role-policy"
  role = aws_iam_role.unauth_iam_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["*"]
        Effect   = "Deny"
        Resource = "*"
      },
    ]
  })
}
