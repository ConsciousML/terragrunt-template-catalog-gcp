variable "instance_name" {
  description = "Name of the Compute Engine instance. Must be unique within the zone and follow GCE naming conventions"
  type        = string
}

variable "machine_type" {
  description = "Machine type defining CPU and memory allocation (e.g., 'e2-micro', 'n1-standard-1', 'c2-standard-4'). See GCE machine types documentation"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Compute Engine zone where the instance will be created (e.g., 'us-central1-a', 'europe-west1-b'). Must be within the specified region"
  type        = string
}

variable "boot_disk_image" {
  description = "Boot disk image family or specific image (e.g., 'debian-cloud/debian-11', 'ubuntu-os-cloud/ubuntu-2204-lts', 'centos-cloud/centos-7')"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_size" {
  description = "Size of the boot disk in gigabytes. Minimum size depends on the chosen image (typically 10GB for Linux)"
  type        = number
}

variable "boot_disk_type" {
  description = "Type of persistent disk for boot volume. Options: 'pd-standard' (HDD), 'pd-ssd' (SSD), 'pd-balanced' (balanced SSD)"
  type        = string
  default     = "pd-standard"
}

variable "network" {
  description = "VPC network self-link where the instance will be attached (e.g., 'projects/PROJECT_ID/global/networks/NETWORK_NAME')"
  type        = string
}

variable "subnetwork" {
  description = "Subnet self-link within the VPC network (e.g., 'projects/PROJECT_ID/regions/REGION/subnetworks/SUBNET_NAME')"
  type        = string
}

variable "enable_external_ip" {
  description = "Whether to assign an external (public) IP address to the instance. Required for internet access without NAT"
  type        = bool
  default     = false
}

variable "metadata" {
  description = "Key-value pairs of metadata to assign to the instance. Common keys: 'ssh-keys', 'startup-script', 'enable-oslogin'"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "List of network tags applied to the instance. Used for firewall rules and network routing"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Email address of the service account to attach to the instance. If null, uses the default Compute Engine service account"
  type        = string
  default     = null
}

variable "service_account_scopes" {
  description = "List of OAuth 2.0 access scopes for the service account. 'cloud-platform' provides full API access"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "allow_stopping_for_update" {
  description = "Whether to allow Terraform to stop the instance to update its properties. Some changes require instance restart"
  type        = bool
  default     = true
}