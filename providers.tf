
terraform {
  required_version = "~>1.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.94"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      workspace = terraform.workspace
    }
  }
}

