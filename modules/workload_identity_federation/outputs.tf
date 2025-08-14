output "workload_identity_provider_name" {
  description = "The full name of the workload identity provider"
  value       = google_iam_workload_identity_pool_provider.github.name
}

output "service_account_email" {
  description = "Email address of the service account"
  value       = google_service_account.github_actions.email
}

output "workload_identity_pool_id" {
  description = "The workload identity pool ID"
  value       = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
}

output "project_number" {
  description = "The project number (needed for some GitHub Actions configurations)"
  value       = google_iam_workload_identity_pool.github_pool.project
}