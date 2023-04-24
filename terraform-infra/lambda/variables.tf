variable "dynamodb_arn" {
  type        = list(string)
  description = "The ARN of the dynamodb resource"
  default     = []
}
variable "dynamodb_stream_arn" {
  type        = list(string)
  description = "The ARN of the dynamodb stream resource"
  default     = []
}
variable "sqs_arn" {
  type        = list(string)
  description = "The ARN of the sqs stream resource"
  default     = []
}
variable "sqs_stream_arn" {
  type        = list(string)
  description = "The ARN of the sqs stream resource"
  default     = []
}
variable "lambda_arn" {
  type        = list(string)
  description = "The ARN of the lambda resource"
  default     = []
}
variable "image_uri" {
  type        = list(string)
  description = "The URI of the image"
  default     = []
}
variable "repository_arn" {
  type        = list(string)
  description = "The ARN of the repository"
  default     = []
}
variable "external_policies_arn" {
  type        = list(string)
  description = "The ARN of the external policies"
  default     = []
}
variable "src_path" {
  description = "Path to the source code"
  type        = string
}
variable "function_name" {
  type        = string
  description = "The name of the function"
}
variable "lambda_env" {
  description = "Lambda environment"
  type        = list(map(string))
  default     = []
}
variable "project" {
  type        = string
  description = "The name of the project"
}
variable "retry_attempts" {
  type        = number
  description = "The number of times to retry when the function returns an error"
  default     = 0
}
variable "filter_criteria" {
  type        = string
  description = "The criteria for the filter"
  default     = "INSERT"
}
