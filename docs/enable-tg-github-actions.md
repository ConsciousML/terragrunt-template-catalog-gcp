Install GitHub CLI.

Auth with GH CLI:
```bash
gh auth login --scopes "repo,admin:repo_hook"
```

Get a fine-graind GH token:
```bash
gh auth token
```

In `bootstrap/enable-tg-github-actions/terragrunt.stack.hcl` change the follwoing:
```hcl
values = {
  # Change these values
  github_username              = "YOUR_USERNAME"
  github_repo_name             = "YOUR_REPO_NAME"
  github_token                 = "YOUR_GH_TOKEN"
  ...
}
```