variable "instance_name" {
  description = "Name of the GCE instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the GCE instance"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Zone where the instance will be created"
  type        = string
}

variable "boot_disk_image" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "boot_disk_size" {
  description = "Boot disk size in GB"
  type        = number
}

variable "boot_disk_type" {
  description = "Boot disk type"
  type        = string
  default     = "pd-standard"
}

variable "network" {
  description = "Network self link"
  type        = string
}

variable "subnetwork" {
  description = "Subnetwork self link"
  type        = string
}

variable "enable_external_ip" {
  description = "Enable external IP for the instance"
  type        = bool
  default     = false
}

variable "metadata" {
  description = "Metadata for the instance"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Network tags for the instance"
  type        = list(string)
  default     = []
}

variable "service_account_email" {
  description = "Service account email"
  type        = string
  default     = null
}

variable "service_account_scopes" {
  description = "Service account scopes"
  type        = list(string)
  default     = ["cloud-platform"]
}

variable "allow_stopping_for_update" {
  description = "Allow stopping for update"
  type        = bool
  default     = true
}