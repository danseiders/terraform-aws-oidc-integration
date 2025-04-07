
terraform {
  required_version = "~>1.11"

  cloud {
    workspaces {
      name    = "oidc-demo-base"
      project = "demo"
    }
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>5.94"
    }
    hcp = {
      source  = "hashicorp/hcp"
      version = "~>0.104"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~>0.64"
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

provider "tfe" {
  token = var.tfe_token
}
