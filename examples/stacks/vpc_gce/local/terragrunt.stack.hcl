locals {
  repo_root = get_repo_root()
  version   = "first-gcp-resources"
}

unit "apis" {
  source = "${local.repo_root}/examples/units/apis"
  path   = "apis"

  values = {
    version = local.version
  }
}

unit "vpc" {
  source = "${local.repo_root}/examples/units/vpc"
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
  source = "${local.repo_root}/examples/units/gce"
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