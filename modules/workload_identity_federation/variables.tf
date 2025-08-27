variable "project" {
  description = "Google Cloud project ID where Workload Identity Federation resources will be created"
  type        = string
}

variable "workload_identity_pool_id" {
  description = "Unique identifier for the workload identity pool (4-32 characters, lowercase letters, numbers, hyphens only)"
  type        = string
}

variable "display_name" {
  description = "Human-readable display name for the workload identity pool (max 32 characters)"
  type        = string
}

variable "description" {
  description = "Optional description explaining the purpose of the workload identity pool (max 256 characters)"
  type        = string
}

variable "service_account_id" {
  description = "Unique identifier for the service account (6-30 characters, lowercase letters, numbers, hyphens only)"
  type        = string
}

variable "service_account_display_name" {
  description = "Human-readable display name for the service account (max 100 characters)"
  type        = string
}

variable "service_account_description" {
  description = "Optional description explaining the purpose of the service account (max 256 characters)"
  type        = string
}

variable "github_username" {
  description = "GitHub username or organization name that will be granted access through Workload Identity Federation"
  type        = string
}

variable "github_repo_name" {
  description = "GitHub repository name that will be granted access through Workload Identity Federation"
  type        = string
}

variable "iam_roles" {
  description = "List of additional IAM roles to assign to the service account (e.g., 'roles/compute.admin', 'roles/storage.objectAdmin'). The 'roles/iam.workloadIdentityUser' role is automatically included"
  type        = list(string)
  default     = []
}