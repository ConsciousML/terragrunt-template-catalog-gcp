include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git::git@github.com:ConsciousML/terragrunt-template-catalog-gcp.git//modules/apis?ref=${values.version}"
}

inputs = {
  apis = values.apis
}

# Using prevent destroy and exclude from destroy because
# APIs take time to be re-enabled. When running destroy in
# dev or staging environment (when running Terratest)
# other deployment fail due the the wait time
prevent_destroy = true

exclude {
  if      = true
  no_run  = true
  actions = ["destroy"]
}