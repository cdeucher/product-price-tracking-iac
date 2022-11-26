variable "cognito_user_pool_arn" {
    type = string
    description = "The ARN of the Cognito User Pool"
}
variable "project" {
    type = string
    description = "The name of the project"
}
variable "rest_api_id" {
    type = string
    description = "The ID of the REST API"
}
variable "resource_id" {
    type = string
    description = "The ID of the resource"
}