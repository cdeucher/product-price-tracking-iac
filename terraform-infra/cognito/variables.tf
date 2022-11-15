variable "cognito_user_pool_name" {
  type        = string
  description = "The name of the user pool"
  default     = "api-gateway-pool"
}

variable "cognito_user_pool_client_name" {
  type        = string
  description = "The name of the user pool client"
  default     = "login_pool"
}