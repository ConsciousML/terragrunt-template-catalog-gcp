unit "apis" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/apis?ref=${values.version}"
  path   = "apis"

  values = {
    version = values.version
  }
}

unit "workload_identity_federation" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/workload_identity_federation?ref=${values.version}"
  path   = "workload_identity_federation"

  values = {
    version                      = values.version
    workload_identity_pool_id    = values.workload_identity_pool_id
    display_name                 = values.display_name
    description                  = values.description
    service_account_id           = values.service_account_id
    service_account_display_name = values.service_account_display_name
    service_account_description  = values.service_account_description
    github_username              = values.github_username
    github_repo_name             = values.github_repo_name
  }
}

unit "github_secrets" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/github_secrets?ref=${values.version}"
  path   = "github_secrets"

  values = {
    version          = values.version
    github_token     = values.github_token
    github_repo_name = values.github_repo_name
  }
}