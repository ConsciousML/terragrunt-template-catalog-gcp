output "public_key" {
  description = "The public key for the deploy key"
  value       = tls_private_key.deploy_key.public_key_openssh
}

output "deploy_key_ids" {
  description = "Map of repository names to deploy key IDs"
  value = {
    for repo, key in github_repository_deploy_key.deploy_key : repo => key.id
  }
}