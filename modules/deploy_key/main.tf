resource "tls_private_key" "deploy_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "github_repository_deploy_key" "deploy_key" {
  for_each = toset(var.repositories)

  title      = var.deploy_key_title
  repository = each.key
  key        = tls_private_key.deploy_key.public_key_openssh
  read_only  = true
}

resource "github_actions_secret" "deploy_key" {
  for_each = toset(var.repositories)

  repository      = each.key
  secret_name     = var.secret_name
  plaintext_value = tls_private_key.deploy_key.private_key_pem
}