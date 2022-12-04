variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "aws_region_availability_zone" {
  default = "us-east-1a"
}

variable "project" {
  type = string
  description = "Project name"
}

variable "env_name" {
  description = "Nome que define o ambiente (dev, stg, prd)"
}

variable "tags" {
    type = map(string)
    description = "Tags para serem aplicadas em todos os recursos"
}

variable "src_path" {
  description = "Path to the source code"
  type        = string
}

variable "subdomain" {
    type        = string
    description = "URL to the Apliaction"
}

variable "domain_name" {
    type        = string
    description = "Domain name"
}

variable "service_account_ci_arn" {
    type = string
    description = "ARN of the service account used by CI"
}