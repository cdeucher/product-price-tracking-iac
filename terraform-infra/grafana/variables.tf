variable "grafana_account_id" {
  type        = string
  description = "The AWS account ID for Grafana Labs."
  validation {
    condition     = length(var.grafana_account_id) > 0
    error_message = "GrafanaAccountID is required."
  }
}
variable "external_id" {
  type        = string
  description = "This is your Grafana Cloud identifier and is used for security purposes."
  validation {
    condition     = length(var.external_id) > 0
    error_message = "ExternalID is required."
  }
}
variable "project" {
  type        = string
  description = "The name of your project."
  validation {
    condition     = length(var.project) > 0
    error_message = "Project is required."
  }
}
