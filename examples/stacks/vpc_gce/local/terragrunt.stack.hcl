locals {
  repo_root = get_repo_root()

  version = coalesce(
    get_env("GITHUB_HEAD_REF", ""), # PR branch name (only set in PRs)
    get_env("GITHUB_REF_NAME", ""), # Branch/tag name
    try(run_cmd("git", "rev-parse", "--abbrev-ref", "HEAD"), ""),
    "main" # fallback
  )
}

unit "apis" {
  source = "${local.repo_root}/units/apis"
  path   = "apis"

  values = {
    version = local.version
  }
}

unit "vpc" {
  source = "${local.repo_root}/units/vpc"
  path   = "vpc"

  values = {
    version      = local.version
    network_name = "vpc"
    subnet_name  = "subnet"
    subnet_cidr  = "10.0.0.0/24"
    region       = "europe-west1"
  }
}

unit "gce" {
  source = "${local.repo_root}/units/gce"
  path   = "gce"

  values = {
    version                = local.version
    instance_name          = "example-instance"
    machine_type           = "e2-micro"
    zone                   = "europe-west1-b"
    boot_disk_image        = "debian-cloud/debian-11"
    boot_disk_size         = 20
    boot_disk_type         = "pd-standard"
    enable_external_ip     = false
    metadata               = {}
    tags                   = ["example-instance"]
    service_account_email  = null
    service_account_scopes = ["cloud-platform"]
  }
}