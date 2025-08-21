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
    workload_identity_pool_id    = values.wif_pool_id
    display_name                 = values.wif_display_name
    description                  = values.wif_description
    service_account_id           = values.wif_service_account_id
    service_account_display_name = values.wif_service_account_display_name
    service_account_description  = values.wif_service_account_description
    github_username              = values.github_username
    github_repo_name             = values.current_repository
    iam_roles                    = values.wif_iam_roles
  }
}

unit "github_secrets" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/github_secrets?ref=${values.version}"
  path   = "github_secrets"

  values = {
    version          = values.version
    github_token     = values.github_token
    github_repo_name = values.current_repository
  }
}

unit "deploy_key" {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//units/deploy_key?ref=${values.version}"
  path   = "deploy_key"

  values = {
    version            = values.version
    github_token       = values.github_token
    repositories       = values.deploy_key_repositories
    secret_names       = values.deploy_key_secret_names
    current_repository = values.current_repository
    deploy_key_title   = values.deploy_key_title
  }
}