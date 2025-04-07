data "tfe_project" "this" {
  name = var.tfe_project_name
}

data "tfe_github_app_installation" "gha_installation" {
  installation_id = var.github_app_installation_id
}


resource "tfe_workspace" "this" {
  name              = var.tfe_workspace_name
  organization      = var.tfe_organization_name
  project_id        = data.tfe_project.this.id
  working_directory = "oidc-config"

  vcs_repo {
    github_app_installation_id = var.github_app_installation_id
    identifier                 = "${data.tfe_github_app_installation.gha_installation.name}/${var.github_repo_name}"
  }
}
