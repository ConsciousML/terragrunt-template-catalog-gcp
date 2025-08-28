<!-- BEGIN_TF_DOCS -->
# Google Compute Engine Module

This module creates and configures a Google Compute Engine virtual machine instance.

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
| [google_compute_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | Whether to allow Terraform to stop the instance to update its properties. Some changes require instance restart | `bool` | `true` | no |
| <a name="input_boot_disk_image"></a> [boot\_disk\_image](#input\_boot\_disk\_image) | Boot disk image family or specific image (e.g., 'debian-cloud/debian-11', 'ubuntu-os-cloud/ubuntu-2204-lts', 'centos-cloud/centos-7') | `string` | `"debian-cloud/debian-11"` | no |
| <a name="input_boot_disk_size"></a> [boot\_disk\_size](#input\_boot\_disk\_size) | Size of the boot disk in gigabytes. Minimum size depends on the chosen image (typically 10GB for Linux) | `number` | n/a | yes |
| <a name="input_boot_disk_type"></a> [boot\_disk\_type](#input\_boot\_disk\_type) | Type of persistent disk for boot volume. Options: 'pd-standard' (HDD), 'pd-ssd' (SSD), 'pd-balanced' (balanced SSD) | `string` | `"pd-standard"` | no |
| <a name="input_enable_external_ip"></a> [enable\_external\_ip](#input\_enable\_external\_ip) | Whether to assign an external (public) IP address to the instance. Required for internet access without NAT | `bool` | `false` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the Compute Engine instance. Must be unique within the zone and follow GCE naming conventions | `string` | n/a | yes |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Machine type defining CPU and memory allocation (e.g., 'e2-micro', 'n1-standard-1', 'c2-standard-4'). See GCE machine types documentation | `string` | `"e2-micro"` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Key-value pairs of metadata to assign to the instance. Common keys: 'ssh-keys', 'startup-script', 'enable-oslogin' | `map(string)` | `{}` | no |
| <a name="input_network"></a> [network](#input\_network) | VPC network self-link where the instance will be attached (e.g., 'projects/PROJECT\_ID/global/networks/NETWORK\_NAME') | `string` | n/a | yes |
| <a name="input_service_account_email"></a> [service\_account\_email](#input\_service\_account\_email) | Email address of the service account to attach to the instance. If null, uses the default Compute Engine service account | `string` | `null` | no |
| <a name="input_service_account_scopes"></a> [service\_account\_scopes](#input\_service\_account\_scopes) | List of OAuth 2.0 access scopes for the service account. 'cloud-platform' provides full API access | `list(string)` | <pre>[<br/>  "cloud-platform"<br/>]</pre> | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Subnet self-link within the VPC network (e.g., 'projects/PROJECT\_ID/regions/REGION/subnetworks/SUBNET\_NAME') | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | List of network tags applied to the instance. Used for firewall rules and network routing | `list(string)` | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Compute Engine zone where the instance will be created (e.g., 'us-central1-a', 'europe-west1-b'). Must be within the specified region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip"></a> [external\_ip](#output\_external\_ip) | External IP address of the GCE instance |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the GCE instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | Name of the GCE instance |
| <a name="output_internal_ip"></a> [internal\_ip](#output\_internal\_ip) | Internal IP address of the GCE instance |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | Self link of the GCE instance |
<!-- END_TF_DOCS -->