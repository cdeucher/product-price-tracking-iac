variable "cognito_user_pool_arn" {
  type        = string
  description = "The ARN of the Cognito User Pool"
}
variable "project" {
  type        = string
  description = "The name of the project"
}
variable "rest_api_id" {
  type        = string
  description = "The ID of the REST API"
}
variable "resource_id" {
  type        = string
  description = "The ID of the resource"
}
variable "authorizer_cognito_enabled" {
  type        = bool
  description = "Whether to enable Cognito as an authorizer"
  default     = false
}
variable "lambda_invoke_arn" {
  type        = string
  description = "The ARN of the Lambda function to invoke"
}
variable "function_name" {
  type        = string
  description = "The function name to use"
}
variable "resource_path" {
  type        = string
  description = "The resource path to use"
}
variable "account_id" {
  type        = string
  description = "The account id to use"
}
variable "region" {
  type        = string
  description = "The region to use"
}