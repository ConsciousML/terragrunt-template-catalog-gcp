locals {
  repo_root = get_repo_root()

  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

unit "apis" {
  source = "${local.repo_root}/units/apis"
  path   = "apis"

  values = {
    version = local.version
  }
}

unit "workload_identity_federation" {
  source = "${local.repo_root}/units/workload_identity_federation"
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