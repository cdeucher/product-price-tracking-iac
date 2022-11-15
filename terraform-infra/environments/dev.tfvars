tabe_name = "titles"
region    = "us-east-1"
accountId = "<aws accountid>"
domain    = "<domain>"
dynamodb_attributes = [
    { name = "text", type = "S" } 
   ,{ name = "date", type = "S" }
]
cognito_user_pool_name = "login_pool"
cognito_user_pool_client_name = "api-gateway-pool"