variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "aws_region_availability_zone" {
  default = "us-east-1a"
}

variable "env_name" {
  description = "Nome que define o ambiente (dev, stg, prd)"
}

variable "tags" {
    type = map(string)
    description = "Tags para serem aplicadas em todos os recursos"
}

locals {
  tag_environment_name = {
    "dev" = "development"
    "stg" = "staging"
    "prd" = "production"
  }
}
variable "src_path" {
  description = "Path to the source code"
  type        = string
}