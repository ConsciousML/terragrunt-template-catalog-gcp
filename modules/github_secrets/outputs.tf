output "secrets_created" {
  description = "List of GitHub secrets that were created"
  value = [
    github_actions_secret.wif_provider.secret_name,
    github_actions_secret.wif_service_account.secret_name,
    github_actions_secret.project_id.secret_name
  ]
}