include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_path_to_repo_root()}//modules/apis"
}

prevent_destroy = true

exclude {
  if      = true
  no_run  = true
  actions = ["destroy"]
}