variable "github_token" {
  description = "GitHub personal access token with 'repo' permissions. Required to create and manage GitHub Actions secrets"
  type        = string
  sensitive   = true
}

variable "github_repo_name" {
  description = "GitHub repository name where secrets will be stored"
  type        = string
}

variable "wif_provider" {
  description = "Workload Identity Federation provider resource name (e.g., 'projects/PROJECT_NUM/locations/global/workloadIdentityPools/POOL_ID/providers/PROVIDER_ID')"
  type        = string
}

variable "wif_service_account" {
  description = "Email address of the service account configured for Workload Identity Federation (e.g., 'service-account@PROJECT_ID.iam.gserviceaccount.com')"
  type        = string
}

variable "project_id" {
  description = "Google Cloud project ID where the Workload Identity Federation is configured"
  type        = string
}