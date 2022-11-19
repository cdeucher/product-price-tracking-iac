tabe_name = "titles"
region    = "us-east-1"
accountId = "260578539897"
domain    = "cabd.link"
dynamodb_attributes = [
    { name = "text", type = "S" } 
   ,{ name = "date", type = "S" }
]
cognito_user_pool_name = "login_pool"
cognito_user_pool_client_name = "api-gateway-pool"