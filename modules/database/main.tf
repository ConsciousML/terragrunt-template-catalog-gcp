resource "google_sql_database_instance" "main" {
  name             = var.instance_name
  database_version = var.database_version
  region           = var.region
  
  deletion_protection = var.deletion_protection

  settings {
    tier = var.tier
    
    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.private_network
      
      authorized_networks {
        name  = var.authorized_network_name
        value = var.authorized_network_value
      }
    }

    backup_configuration {
      enabled            = var.backup_enabled
      start_time         = var.backup_start_time
      location           = var.backup_location
      point_in_time_recovery_enabled = var.point_in_time_recovery_enabled
    }

    maintenance_window {
      day          = var.maintenance_window_day
      hour         = var.maintenance_window_hour
      update_track = var.maintenance_window_update_track
    }
  }
}