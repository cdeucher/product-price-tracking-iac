variable "table_name" {
  description = "DynamoDB table titles will be stored in"
}
variable "attributes" {
  type = list(object({ name = string, type = string }))
}