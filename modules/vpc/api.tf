# Enable Service Networking API
resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"
}

