data "aws_iam_role" "run_role" {
  name = "tfc-oidc"
}
resource "tfe_variable" "oidc_auth" {
  key          = "TFC_AWS_PROVIDER_AUTH"
  value        = true
  category     = "env"
  description  = "Boolean to determine if the AWS provider should be authenticated using OIDC"
  workspace_id = tfe_workspace.this.id
}

resource "tfe_variable" "oidc_run_role_arn" {
  key          = "TFC_AWS_RUN_ROLE_ARN"
  value        = data.aws_iam_role.run_role.arn
  category     = "env"
  description  = "The ARN of the role to assume for OIDC authentication"
  workspace_id = tfe_workspace.this.id
}
