variable "table_name" {
  description = "DynamoDB table titles will be stored in"
}
variable "attributes" {
  type = object({ sort_key = string, sort_type = string })
}