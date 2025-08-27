resource "google_project_service" "wif_required_apis" {
  for_each = toset(var.apis)

  service = each.value

  disable_on_destroy         = false
  disable_dependent_services = false
}