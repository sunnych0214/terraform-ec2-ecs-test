terraform {
  required_version = "1.4.6"
  required_providers {
    aws = ">= 5.0.0"
  }
}

provider "aws" {
  region = var.aws_region
  profile = "default"
}

