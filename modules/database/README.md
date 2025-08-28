<!-- BEGIN_TF_DOCS -->
# Database Module

This module creates and configures a Cloud SQL database instance.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 6.48 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 6.48 |

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_authorized_network_name"></a> [authorized\_network\_name](#input\_authorized\_network\_name) | Name identifier for the authorized network entry. Used for labeling the network access rule | `string` | `"all"` | no |
| <a name="input_authorized_network_value"></a> [authorized\_network\_value](#input\_authorized\_network\_value) | CIDR block that can access the database instance (e.g., '10.0.0.0/8', '192.168.1.0/24'). Default '0.0.0.0/0' allows all IPs | `string` | `"0.0.0.0/0"` | no |
| <a name="input_backup_enabled"></a> [backup\_enabled](#input\_backup\_enabled) | Whether automated backups are enabled. Highly recommended for production databases | `bool` | `true` | no |
| <a name="input_backup_location"></a> [backup\_location](#input\_backup\_location) | Geographic location where backups are stored (e.g., 'us', 'eu', 'asia'). Should match or be close to your instance region for compliance and performance | `string` | n/a | yes |
| <a name="input_backup_start_time"></a> [backup\_start\_time](#input\_backup\_start\_time) | Start time for automated backups in HH:MM format (UTC). Choose a time during low-traffic periods | `string` | `"03:00"` | no |
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | Database engine version (e.g., 'POSTGRES\_15', 'POSTGRES\_14', 'MYSQL\_8\_0'). See Cloud SQL documentation for supported versions | `string` | `"POSTGRES_15"` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether deletion protection is enabled. When true, prevents accidental deletion of the database instance | `bool` | `false` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the Cloud SQL database instance. Must be unique within the project and contain only lowercase letters, numbers, and hyphens | `string` | n/a | yes |
| <a name="input_ipv4_enabled"></a> [ipv4\_enabled](#input\_ipv4\_enabled) | Whether the database instance should be assigned a public IPv4 address. Set to false for private-only access | `bool` | `true` | no |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | Day of week for maintenance window (1=Monday, 7=Sunday). Updates and patches will be applied during this window | `number` | `7` | no |
| <a name="input_maintenance_window_hour"></a> [maintenance\_window\_hour](#input\_maintenance\_window\_hour) | Hour of day for maintenance window (0-23, UTC). Choose a time during low-traffic periods | `number` | `4` | no |
| <a name="input_maintenance_window_update_track"></a> [maintenance\_window\_update\_track](#input\_maintenance\_window\_update\_track) | Update track for maintenance releases. 'stable' for production environments, 'canary' for early access to features | `string` | `"stable"` | no |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | Whether point-in-time recovery (PITR) is enabled. Allows recovery to any specific time within the retention period | `bool` | `true` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | VPC network self-link for private IP allocation (e.g., 'projects/PROJECT\_ID/global/networks/NETWORK\_NAME'). Required for private IP connectivity | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | GCP region where the database instance will be created (e.g., 'us-central1', 'europe-west1') | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Machine type/tier for the database instance (e.g., 'db-f1-micro', 'db-n1-standard-1', 'db-custom-2-7680'). Determines CPU and memory allocation | `string` | `"db-f1-micro"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_name"></a> [connection\_name](#output\_connection\_name) | Connection name of the database instance |
| <a name="output_instance_ip"></a> [instance\_ip](#output\_instance\_ip) | IP address of the database instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Name of the database instance |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | Self link of the database instance |
<!-- END_TF_DOCS -->