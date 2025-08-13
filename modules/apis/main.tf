locals {
  apis = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
    "compute.googleapis.com",
    "servicenetworking.googleapis.com"
  ]
}

resource "google_project_service" "wif_required_apis" {
  for_each = toset(local.apis)

  service = each.value

  disable_on_destroy         = false
  disable_dependent_services = false
}