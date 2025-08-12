output "instance_name" {
  description = "Name of the database instance"
  value       = google_sql_database_instance.main.name
}

output "connection_name" {
  description = "Connection name of the database instance"
  value       = google_sql_database_instance.main.connection_name
}

output "instance_ip" {
  description = "IP address of the database instance"
  value       = google_sql_database_instance.main.ip_address
}

output "self_link" {
  description = "Self link of the database instance"
  value       = google_sql_database_instance.main.self_link
}