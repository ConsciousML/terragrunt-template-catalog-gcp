include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/database?ref=${values.version}"
}

dependency "apis" {
  config_path  = "../apis"
  skip_outputs = true
}

dependency "vpc" {
  config_path = "../vpc"
  mock_outputs = {
    network_self_link = "projects/main-project-468812/global/networks/mock-vpc"
  }
  mock_outputs_allowed_terraform_commands = ["init", "plan", "validate", "destroy"]
}

inputs = {
  instance_name    = "${local.environment}-${values.instance_name}"
  database_version = values.database_version
  region           = values.region
  backup_location  = values.backup_location
  private_network  = dependency.vpc.outputs.network_self_link
}