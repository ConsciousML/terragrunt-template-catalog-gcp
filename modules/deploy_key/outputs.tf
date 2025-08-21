output "public_keys" {
  description = "Map of repository names to public keys"
  value = {
    for repo in var.repositories : repo => tls_private_key.deploy_key[repo].public_key_openssh
  }
}

output "deploy_key_ids" {
  description = "Map of repository names to deploy key IDs"
  value = {
    for repo, key in github_repository_deploy_key.deploy_key : repo => key.id
  }
}

output "secret_names" {
  description = "List of secret names created for each repository"
  value       = var.secret_names
}