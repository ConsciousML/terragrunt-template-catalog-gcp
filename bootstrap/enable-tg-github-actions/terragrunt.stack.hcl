stack "enable_tg_github_actions" {
  source = "${get_repo_root()}/stacks/enable-tg-github-actions"
  path   = "enable_tg_github_actions"

  values = {
    # Change these values
    github_username  = "ConsciousML"
    github_repo_name = "terragrunt-template-catalog-gcp"

    # Set github_token via environment variable: export TF_VAR_github_token="your_token_here"
    github_token = get_env("TF_VAR_github_token")

    # TODO: change version to `main` before merge
    version                      = "first-gcp-resources"
    workload_identity_pool_id    = "gh-pool"
    display_name                 = "GitHub pool"
    description                  = "Identity pool for GitHub deployments"
    service_account_id           = "gh-actions"
    service_account_display_name = "GitHub Actions Service Account"
    service_account_description  = "Service account for GitHub Actions workflows"
  }
}