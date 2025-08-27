variable "instance_name" {
  description = "Name of the Cloud SQL database instance. Must be unique within the project and contain only lowercase letters, numbers, and hyphens"
  type        = string
}

variable "database_version" {
  description = "Database engine version (e.g., 'POSTGRES_15', 'POSTGRES_14', 'MYSQL_8_0'). See Cloud SQL documentation for supported versions"
  type        = string
  default     = "POSTGRES_15"
}

variable "region" {
  description = "GCP region where the database instance will be created (e.g., 'us-central1', 'europe-west1')"
  type        = string
}

variable "tier" {
  description = "Machine type/tier for the database instance (e.g., 'db-f1-micro', 'db-n1-standard-1', 'db-custom-2-7680'). Determines CPU and memory allocation"
  type        = string
  default     = "db-f1-micro"
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled. When true, prevents accidental deletion of the database instance"
  type        = bool
  default     = false
}

variable "ipv4_enabled" {
  description = "Whether the database instance should be assigned a public IPv4 address. Set to false for private-only access"
  type        = bool
  default     = true
}

variable "private_network" {
  description = "VPC network self-link for private IP allocation (e.g., 'projects/PROJECT_ID/global/networks/NETWORK_NAME'). Required for private IP connectivity"
  type        = string
  default     = null
}

variable "authorized_network_name" {
  description = "Name identifier for the authorized network entry. Used for labeling the network access rule"
  type        = string
  default     = "all"
}

variable "authorized_network_value" {
  description = "CIDR block that can access the database instance (e.g., '10.0.0.0/8', '192.168.1.0/24'). Default '0.0.0.0/0' allows all IPs"
  type        = string
  default     = "0.0.0.0/0"
}

variable "backup_enabled" {
  description = "Whether automated backups are enabled. Highly recommended for production databases"
  type        = bool
  default     = true
}

variable "backup_start_time" {
  description = "Start time for automated backups in HH:MM format (UTC). Choose a time during low-traffic periods"
  type        = string
  default     = "03:00"
}

variable "backup_location" {
  description = "Geographic location where backups are stored (e.g., 'us', 'eu', 'asia'). Should match or be close to your instance region for compliance and performance"
  type        = string
}

variable "point_in_time_recovery_enabled" {
  description = "Whether point-in-time recovery (PITR) is enabled. Allows recovery to any specific time within the retention period"
  type        = bool
  default     = true
}

variable "maintenance_window_day" {
  description = "Day of week for maintenance window (1=Monday, 7=Sunday). Updates and patches will be applied during this window"
  type        = number
  default     = 7
}

variable "maintenance_window_hour" {
  description = "Hour of day for maintenance window (0-23, UTC). Choose a time during low-traffic periods"
  type        = number
  default     = 4
}

variable "maintenance_window_update_track" {
  description = "Update track for maintenance releases. 'stable' for production environments, 'canary' for early access to features"
  type        = string
  default     = "stable"
}