locals {
  version = "first-gcp-resources"
}

include "catalog" {
  path = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//stacks/enable-tg-github-actions/terragrunt.stack.hcl?ref=${local.version}"
}

values = {
  # Change these values
  github_username  = "ConsciousML"
  github_repo_name = "terragrunt-template-catalog-gcp"

  # Default values
  version                      = local.version
  workload_identity_pool_id    = "github-pool-oidc"
  display_name                 = "GitHub pool"
  description                  = "Identity pool for GitHub deployments"
  service_account_id           = "github-actions"
  service_account_display_name = "GitHub Actions Service Account"
  service_account_description  = "Service account for GitHub Actions workflows"

}