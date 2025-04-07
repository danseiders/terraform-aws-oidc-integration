# Terraform AWS OIDC Integration Example

This Terraform module sets up an AWS IAM Role and associated identity provider to enable secure OpenID Connect (OIDC) authentication, typically for use with GitHub Actions or other OIDC-compatible CI/CD systems.

## Features

- Creates an AWS OIDC identity provider
- Configures trust policy

Hashicorp Docs
https://developer.hashicorp.com/terraform/cloud-docs/workspaces/dynamic-provider-credentials/aws-configuration
