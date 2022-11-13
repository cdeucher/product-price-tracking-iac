variable "tabe_name" {
  type = string
  description = "The name of the table to create"
}
variable "dynamodb_arn" {
  type = string
  description = "The ARN of the dynamodb resource"
}
variable "dymanodb_stream_arn" {
    type = string
    description = "The ARN of the dynamodb stream resource"
}