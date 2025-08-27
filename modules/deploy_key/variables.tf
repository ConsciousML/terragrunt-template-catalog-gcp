variable "github_token" {
  description = "GitHub personal access token with 'repo' and 'admin:repo_hook' permissions. Required to create deploy keys and manage repository settings"
  type        = string
  sensitive   = true
}

variable "repositories" {
  description = "List of GitHub repository names (format: 'repo-name') where deploy keys will be added for secure access"
  type        = list(string)
}

variable "secret_names" {
  description = "List of GitHub Actions secret names for storing private keys. Must correspond 1:1 with the repositories list (same order)"
  type        = list(string)
}

variable "current_repository" {
  description = "GitHub repository name (format: 'repo-name') where the GitHub Actions secrets will be stored"
  type        = string
}

variable "deploy_key_title" {
  description = "Human-readable title for the deploy key as it appears in GitHub repository settings"
  type        = string
  default     = "Terragrunt Deploy Key"
}