# Settings
variable "authorizer_cognito_enabled" {
  type = bool
  default = false
  description = "Activate Cognito"
}

variable "region" {
  description = "AWS region"
  type        = string
}
variable "environment" {
  default = "dev"
  type = string
  description = "Environment name"
}
variable "project" {
  default = "myapp"
  type = string
  description = "Project name"
}
variable "tags" {
  type = map(string)
  description = "Tags to apply to all resources"
}
variable "domain" {
  description = "Domain url of the website"
}

# Lambda Title
variable "lambda_env" {
    description = "Lambda environment"
    type = list(map(string))
}

# DYNAMODB
variable "tabe_name" {
  description = "DynamoDB table titles will be stored in"
  type        = string
}
variable "accountId" {
  description = "AWS account ID"
  type        = string
}
variable "dynamodb_attributes" {
  type        = list(object({ name = string, type = string }))
}

# COGNITO
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