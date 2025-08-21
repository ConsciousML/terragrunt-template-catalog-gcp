variable "github_token" {
  description = "GitHub personal access token with repo permissions"
  type        = string
  sensitive   = true
}

variable "repositories" {
  description = "List of repository names to add the deploy key to"
  type        = list(string)
}

variable "secret_names" {
  description = "List of GitHub Actions secret names to store each deploy key (must match order of repositories)"
  type        = list(string)
}

variable "current_repository" {
  description = "Name of the current repository where secrets will be stored"
  type        = string
}

variable "deploy_key_title" {
  description = "Title for the deploy key"
  type        = string
  default     = "Terragrunt Deploy Key"
}