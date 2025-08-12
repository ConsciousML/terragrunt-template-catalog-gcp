include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-stack-gcp.git//modules/apis?ref=first-gcp-resources"
}