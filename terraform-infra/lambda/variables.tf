variable "dynamodb_arn" {
    type        = list(string)
    description = "The ARN of the dynamodb resource"
    default     = []
}
variable "dymanodb_stream_arn" {
    type        = list(string)
    description = "The ARN of the dynamodb stream resource"
    default     = []
}
variable "src_path" {
    description = "Path to the source code"
    type        = string
}
variable "function_name" {
    type = string
    description = "The name of the function"
}
variable "lambda_env" {
    description = "Lambda environment"
    type    = list(map(string))
    default = []
}
variable "project" {
    type = string
    description = "The name of the project"
}