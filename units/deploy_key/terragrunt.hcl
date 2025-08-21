include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/deploy_key/?ref=${values.version}"
}

inputs = {
  github_token       = values.github_token
  repositories       = values.repositories
  secret_names       = values.secret_names
  current_repository = values.current_repository
  deploy_key_title   = values.deploy_key_title
}