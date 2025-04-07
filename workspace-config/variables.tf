variable "tfe_organization_name" {
  type        = string
  description = "The name of your Terraform Cloud organization"
}

variable "tfe_project_name" {
  type        = string
  description = "The project under which a workspace will be created"
}

variable "tfe_workspace_name" {
  type        = string
  description = "The name of the workspace that you'd like to create and connect to AWS"
  default     = "Default Project"
}

variable "github_app_installation_id" {
  type        = string
  description = "The name of the GitHub App installation"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to use"
  default     = "us-east-2"
}

variable "github_repo_name" {
  type        = string
  description = "The name of the GitHub repository"
}

variable "tfe_token" {
  type        = string
  description = "The token to use for TFE authentication"
}
