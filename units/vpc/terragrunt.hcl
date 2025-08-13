include "root" {
  path = find_in_parent_folders("root.hcl")
}

locals {
  environment_hcl = find_in_parent_folders("environment.hcl")
  environment     = read_terragrunt_config(local.environment_hcl).locals.environment
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/vpc?ref=first-gcp-resources"
}

dependency "apis" {
  config_path = "../apis"
  skip_outputs = true
}

inputs = {
  network_name = "${local.environment}-${values.network_name}"
  subnet_name  = "${local.environment}-${values.subnet_name}"
  subnet_cidr  = values.subnet_cidr
  region       = values.region
}