variable "project" {
    type = string
    description = "The project ID to deploy to"
}
variable "cognito_user_pool_name" {
    type        = string
    description = "The name of the user pool"
    default     = "api-gateway-pool"
}

variable "cognito_user_pool_client_name" {
    type        = string
    description = "The name of the user pool client"
    default     = "login_pool"
}

variable "domain_callback_url" {
    type        = string
    description = "The callback url for the domain"
}

variable "gcp_client_id" {
    type        = string
    sensitive   = true
    description = "The client id for the GCP application"
}
variable "gcp_client_secret" {
    type        = string
    sensitive   = true
    description = "The client secret for the GCP application"
}
variable "domain" {
    type        = string
    description = "The domain name"
}