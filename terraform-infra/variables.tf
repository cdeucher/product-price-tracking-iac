variable "env_name" {
  default = "dev"
}
variable "domain" {
  description = "Domain url of the website"
}
variable "tabe_name" {
  description = "DynamoDB table titles will be stored in"
  type        = string
}
variable "region" {
  description = "AWS region"
  type        = string
}
variable "accountId" {
  description = "AWS account ID"
  type        = string
}
variable "dynamodb_attributes" {
  type        = list(object({ name = string, type = string }))
}