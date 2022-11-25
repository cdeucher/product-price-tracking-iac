# General
region    = "us-east-1"
accountId = "260578539897"
domain    = "cabd.link"
tags = {
    Name             = "app"
    Environment      = "dev"
    Owner            = "me"
    Application      = "app"
    Environment_Type = "dev"
    Environment_Name = "dev"
}
project = "app"
environment = "dev"

# Lambda
lambda_env = [{ TITLES_TABLE = "titles" }]

# Dynamo
tabe_name = "titles"
dynamodb_attributes = [
    { name = "text", type = "S" }
   ,{ name = "date", type = "S" }
]
cognito_user_pool_name = "login_pool"
cognito_user_pool_client_name = "api-gateway-pool"
