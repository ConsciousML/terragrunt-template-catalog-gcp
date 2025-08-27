# Create SSH keys
resource "tls_private_key" "deploy_key" {
  for_each = toset(var.repositories)

  algorithm = "RSA"
  rsa_bits  = 4096
}

# Add each SSH key as deploy key for each repository
resource "github_repository_deploy_key" "deploy_key" {
  for_each = toset(var.repositories)

  title      = var.deploy_key_title
  repository = each.key
  key        = tls_private_key.deploy_key[each.key].public_key_openssh
  read_only  = true
}

# Add the private key of each deploy key to the current repository
# i.e where GH Actions will run
resource "github_actions_secret" "deploy_key" {
  count = length(var.repositories)

  repository      = var.current_repository
  secret_name     = var.secret_names[count.index]
  plaintext_value = tls_private_key.deploy_key[var.repositories[count.index]].private_key_openssh
}