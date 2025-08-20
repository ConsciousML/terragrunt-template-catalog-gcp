variable "project" {
  description = "GCP project ID"
  type        = string
}

variable "workload_identity_pool_id" {
  description = "ID of the workload identity pool"
  type        = string
}

variable "display_name" {
  description = "Display name for the workload identity pool"
  type        = string
}

variable "description" {
  description = "Description for the workload identity pool"
  type        = string
}

variable "service_account_id" {
  description = "ID of the service account"
  type        = string
}

variable "service_account_display_name" {
  description = "Display name for the service account"
  type        = string
}

variable "service_account_description" {
  description = "Description for the service account"
  type        = string
}

variable "github_username" {
  description = "GitHub username"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name"
  type        = string
}

variable "iam_roles" {
  description = "Additional IAM roles to assign to the service account (roles/iam.workloadIdentityUser is always included)"
  type        = list(string)
  default     = []
}