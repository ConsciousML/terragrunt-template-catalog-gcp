include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/workload_identity_federation/?ref=${values.version}"
}

dependency "apis" {
  config_path  = "../apis"
  skip_outputs = true
}

inputs = {
  workload_identity_pool_id    = "${local.environment}-${values.workload_identity_pool_id}"
  display_name                 = values.display_name
  description                  = values.description
  service_account_id           = "${local.environment}-${values.service_account_id}"
  service_account_display_name = values.service_account_display_name
  service_account_description  = values.service_account_description
  github_username              = values.github_username
  github_repo_name             = values.github_repo_name
}