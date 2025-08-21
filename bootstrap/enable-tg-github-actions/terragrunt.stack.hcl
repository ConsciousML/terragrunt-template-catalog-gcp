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
    version = "first-gcp-resources"

    # Workload Identity Federation configuration
    wif_pool_id                      = "gh-pool"
    wif_display_name                 = "GitHub pool"
    wif_description                  = "Identity pool for GitHub deployments"
    wif_service_account_id           = "gh-actions"
    wif_service_account_display_name = "GitHub Actions Service Account"
    wif_service_account_description  = "Service account for GitHub Actions workflows"

    # GitHub Secrets configuration
    github_secrets_repo_name = "terragrunt-template-catalog-gcp"

    # Deploy key configuration
    deploy_key_repositories = ["terragrunt-template-catalog-gcp"]
    deploy_key_secret_name  = "DEPLOY_KEY"
    deploy_key_title        = "Terragrunt Deploy Key"
  }
}