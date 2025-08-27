variable "network_name" {
  description = "Name of the VPC network. Must be unique within the project and follow GCP naming conventions"
  type        = string
}

variable "subnet_name" {
  description = "Name of the subnet within the VPC network. Must be unique within the region"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet in IPv4 format (e.g., '10.0.1.0/24', '192.168.0.0/16'). Must not overlap with other subnets"
  type        = string
}

variable "region" {
  description = "GCP region where the subnet will be created (e.g., 'us-central1', 'europe-west1'). Network is global, subnet is regional"
  type        = string
}