terraform {
  required_version = ">= 0.14.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.75.2"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.2.0"
    }
  }
}
provider "aws" {
  region      = var.region
}
