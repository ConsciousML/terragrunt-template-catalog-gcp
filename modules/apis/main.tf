resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"
}