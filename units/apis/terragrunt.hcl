include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/apis?ref=${values.version}"
}

prevent_destroy = true

exclude {
  if      = true
  no_run  = true
  actions = ["destroy"]
}