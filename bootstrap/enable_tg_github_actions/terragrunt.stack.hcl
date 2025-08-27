locals {
  # Sets the reference of the source code to:
  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

stack "enable_tg_github_actions" {
  source = "${get_repo_root()}/stacks/enable_tg_github_actions"
  path   = "enable_tg_github_actions"

  values = {
    github_username    = "ConsciousML"
    current_repository = "terragrunt-template-catalog-gcp"

    # Set github_token via environment variable to use the GitHub TF provider
    github_token = get_env("TF_VAR_github_token")

    version = local.version

    # Workload Identity Federation configuration
    wif_pool_id                      = "gh-pool"
    wif_display_name                 = "GitHub pool"
    wif_description                  = "Identity pool for GitHub deployments"
    wif_service_account_id           = "gh-actions"
    wif_service_account_display_name = "GitHub Actions Service Account"
    wif_service_account_description  = "Service account for GitHub Actions workflows"
    wif_iam_roles = [
      "roles/viewer",                          # Basic read access to all resources
      "roles/storage.admin",                   # Full access to Cloud Storage (for Terraform state)
      "roles/compute.networkAdmin",            # Create/manage VPCs, subnets, global addresses
      "roles/compute.instanceAdmin.v1",        # Create/manage GCE instances
      "roles/servicenetworking.networksAdmin", # Create private service connections
      "roles/serviceusage.serviceUsageAdmin",  # Enable/disable GCP APIs
      "roles/iam.serviceAccountUser"           # Use default Compute Engine service account
    ]

    # APIs required for GitHub Actions
    apis = [
      "iam.googleapis.com",
      "cloudresourcemanager.googleapis.com",
      "iamcredentials.googleapis.com",
      "sts.googleapis.com"
    ]

    # Deploy key configuration
    deploy_key_repositories = ["terragrunt-template-catalog-gcp"]
    deploy_key_secret_names = ["DEPLOY_KEY_TG_CATALOG"]
    deploy_key_title        = "Terragrunt Catalog Deploy Key"
  }
}