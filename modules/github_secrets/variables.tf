variable "github_token" {
  description = "GitHub personal access token with repo permissions"
  type        = string
  sensitive   = true
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "wif_provider" {
  description = "Workload Identity Federation provider name"
  type        = string
}

variable "wif_service_account" {
  description = "Workload Identity Federation service account email"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}