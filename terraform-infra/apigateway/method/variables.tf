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
variable "http_method" {
    type = string
    description = "The HTTP method"
}
variable "invoke_url" {
    type = string
    description = "The URL to invoke the Lambda function"
}