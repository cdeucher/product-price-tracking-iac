variable "table_name" {
  description = "DynamoDB table titles will be stored in"
}
variable "attributes" {
  type = list(map(string))
}
variable "dynamodb_hash_key" {
  type = string
}
variable "dynamodb_range_key" {
  type = string
}
