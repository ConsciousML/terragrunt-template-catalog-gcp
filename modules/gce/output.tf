output "instance_name" {
  description = "Name of the GCE instance"
  value       = google_compute_instance.main.name
}

output "instance_id" {
  description = "ID of the GCE instance"
  value       = google_compute_instance.main.id
}

output "internal_ip" {
  description = "Internal IP address of the GCE instance"
  value       = google_compute_instance.main.network_interface[0].network_ip
}

output "external_ip" {
  description = "External IP address of the GCE instance"
  value       = length(google_compute_instance.main.network_interface[0].access_config) > 0 ? google_compute_instance.main.network_interface[0].access_config[0].nat_ip : null
}

output "self_link" {
  description = "Self link of the GCE instance"
  value       = google_compute_instance.main.self_link
}