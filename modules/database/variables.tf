variable "instance_name" {
  description = "Name of the database instance"
  type        = string
}

variable "database_version" {
  description = "Database version"
  type        = string
  default     = "POSTGRES_15"
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "tier" {
  description = "Database tier"
  type        = string
  default     = "db-f1-micro"
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "ipv4_enabled" {
  description = "Enable IPv4"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "Private network self link"
  type        = string
  default     = null
}

variable "authorized_network_name" {
  description = "Authorized network name"
  type        = string
  default     = "all"
}

variable "authorized_network_value" {
  description = "Authorized network CIDR"
  type        = string
  default     = "0.0.0.0/0"
}

variable "backup_enabled" {
  description = "Enable backups"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Backup start time"
  type        = string
  default     = "03:00"
}

variable "backup_location" {
  description = "Backup location"
  type        = string
}

variable "point_in_time_recovery_enabled" {
  description = "Enable point in time recovery"
  type        = bool
  default     = true
}

variable "maintenance_window_day" {
  description = "Maintenance window day"
  type        = number
  default     = 7
}

variable "maintenance_window_hour" {
  description = "Maintenance window hour"
  type        = number
  default     = 4
}

variable "maintenance_window_update_track" {
  description = "Maintenance window update track"
  type        = string
  default     = "stable"
}