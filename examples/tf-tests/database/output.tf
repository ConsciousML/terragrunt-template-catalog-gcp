output "instance_name" {
  description = "The name of the Cloud SQL database instance"
  value       = module.database.instance_name
}

output "instance_ip" {
  description = "The IP address of the Cloud SQL database instance"
  value       = module.database.instance_ip
}

output "connection_name" {
  description = "The connection name of the Cloud SQL database instance"
  value       = module.database.connection_name
}

output "self_link" {
  description = "The URI of the Cloud SQL database instance"
  value       = module.database.self_link
}