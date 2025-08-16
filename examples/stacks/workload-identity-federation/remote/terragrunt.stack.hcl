locals {
  repo_root = get_repo_root()
  version   = "first-gcp-resources"
}

unit "apis" {
  source = "${local.repo_root}/units/apis"
  path   = "apis"

  values = {
    version = "first-gcp-resources"
  }
}

unit "workload_identity_federation" {
  source = "github.com/ConsciousML/terragrunt-template-catalog-gcp//units/workload_identity_federation?ref=${local.version}"
  path   = "workload_identity_federation"

  values = {
    version                      = local.version
    workload_identity_pool_id    = "github-pool-oidc"
    display_name                 = "GitHub pool"
    description                  = "Identity pool for GitHub deployments"
    service_account_id           = "github-actions"
    service_account_display_name = "GitHub Actions Service Account"
    service_account_description  = "Service account for GitHub Actions workflows"
    github_username              = "your-github-username"
    github_repo_name             = "your-repo-name"
  }
}