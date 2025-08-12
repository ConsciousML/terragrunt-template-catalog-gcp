output "network_name" {
  description = "Name of the VPC network"
  value       = module.vpc.network_name
}

output "network_id" {
  description = "ID of the VPC network"
  value       = module.vpc.network_id
}

output "network_self_link" {
  description = "Self-link of the VPC network"
  value       = module.vpc.network_self_link
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = module.vpc.subnet_name
}

output "subnet_id" {
  description = "ID of the subnet"
  value       = module.vpc.subnet_id
}

output "subnet_self_link" {
  description = "Self-link of the subnet"
  value       = module.vpc.subnet_self_link
}