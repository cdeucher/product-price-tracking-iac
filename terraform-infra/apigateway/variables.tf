variable "add_title_function_name" {
  type = string
  description = "The name of the Lambda function that will be invoked to add a titles to the table"
}
variable "region" {
  type = string
  description = "AWS region"
}
variable "account_id" {
  type = string
  description = "AWS account ID"
}
variable "sub_domain" {
    type = string
    description = "The subdomain of the application"
}
variable "domain" {
  type = string
  description = "The domain of the application"
}
variable "invoke_url" {
  type = string
  description = "The invoke url of the website"
}