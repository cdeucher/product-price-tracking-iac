variable "project" {
  type        = string
  description = "Project name"
}
variable "function_name" {
  type        = string
  description = "Function name"
}
variable "role_arn" {
  type        = string
  description = "Role ARN"
}
variable "lambda_env" {
  description = "Lambda environment"
  type        = list(map(string))
  default     = []
}
variable "output_path" {
  type        = string
  description = "Output path"
  default     = ""
}
variable "layer_arn" {
  type        = string
  description = "Layer ARN"
  default     = ""
}
variable "output_base64sha256" {
  type        = string
  description = "Output base64sha256"
  default     = ""
}
variable "image_uri" {
  type        = list(string)
  description = "The URI of the image"
  default     = []
}
