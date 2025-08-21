variable "github_token" {
  description = "GitHub personal access token with repo permissions"
  type        = string
  sensitive   = true
}

variable "repositories" {
  description = "List of repository names to add the deploy key to"
  type        = list(string)
}

variable "secret_name" {
  description = "Name of the GitHub Actions secret to store the deploy key"
  type        = string
  default     = "DEPLOY_KEY"
}

variable "deploy_key_title" {
  description = "Title for the deploy key"
  type        = string
  default     = "Terragrunt Deploy Key"
}