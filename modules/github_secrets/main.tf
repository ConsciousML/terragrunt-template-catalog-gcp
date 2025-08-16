resource "github_actions_secret" "wif_provider" {
  repository      = var.github_repo_name
  secret_name     = "WIF_PROVIDER"
  plaintext_value = var.wif_provider
}

resource "github_actions_secret" "wif_service_account" {
  repository      = var.github_repo_name
  secret_name     = "WIF_SERVICE_ACCOUNT"
  plaintext_value = var.wif_service_account
}

resource "github_actions_secret" "project_id" {
  repository      = var.github_repo_name
  secret_name     = "PROJECT_ID"
  plaintext_value = var.project_id
}