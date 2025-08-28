# GitHub Actions GCP Bootstrap
Enables GitHub Actions deployment to Google Cloud Platform using Terragrunt with minimal manual steps.

## Purpose

Run this **once** after creating a new GitHub repository from this template to authenticate GitHub Actions with GCP.

This enables the CI to run properly without managing secrets and GCP service account keys manually.

## Quick Start

### Prerequisites
- Follow the [installation instructions](../README.md#installation):
- GCP project with billing enabled
- GCP IAM permissions to create service accounts and workload identity pools

### Configuration
In `bootstrap/` change `region.hcl` and `project.hcl` to match your GCP settings.
Update the following values in `terragrunt.stack.hcl`:

```hcl
values = {
  github_username      = "YourGitHubUsername"
  current_repository   = "your-current-repo-name"

  # List of the roles necessary for Terragrunt to run in CI/CD
  wif_iam_roles = [
    "role_1",
    ...
    "role_N"
  ]

  # List of repository names to give read-only access to the CI
  # This is necessary for Terragrunt to pull remote source code from external repositories
  deploy_key_repositories = [
    "repo_name_1",
    ...
    "repo_name_N"
  ]

  # Attribute a secret name for each deploy key. Use the same order as the
  # deploy_key_repositories
  deploy_key_secret_names = [
    "DEPLOY_KEY_1",
    ...
    "DEPLOY_KEY_N
  ]

  deploy_key_title = "Terragrunt Catalog Deploy Key"
  # ... other values can remain as defaults
}
```

Autenticate with the GitHub CLI:
```bash
gh auth login --scopes "repo,admin:repo_hook"
```

Add a GitHub fine-grained token to your environment variables:
```bash
export TF_VAR_github_token="$(gh auth token)"
```

### Deploy
```bash
cd bootstrap/enable_tg_github_actions/
terragrunt stack generate
terragrunt stack run apply
```

### Update Your GitHub Actions file

Update your `.github/workflows/ci.yaml` to use the correct deploy key secret names:

For single deploy key to match the value in `deploy_key_secret_names`:
```yaml
# Change this line:
ssh-private-key: ${{ secrets.DEPLOY_KEY }}
```

If using multiple deploy keys:
```yaml
- uses: webfactory/ssh-agent@v0.9.0
  with:
    ssh-private-key: |
      ${{ secrets.DEPLOY_KEY_SECRET_NAME_1 }}
      ${{ secrets.DEPLOY_KEY_SECRET_NAME_2 }}
```

### Using the CI
Read the [continuous integration guide](../docs/continuous-integration.md#using-the-ci).

## Troubleshoot
If you face an error:
```bash
Error: Error creating WorkloadIdentityPool: googleapi: Error 409: Requested entity already exists
```

This happends because WIP can only be soft-deleted. GCP deletes it after 30 days.
So we'll need to undelete it and import it in your TF state.

In the trace, under `google_iam_workload_identity_pool_provider.github` find the WIP ID:
```bash
workload_identity_pool_id          = "YOUR_WIP_ID"
```

Declare the `WIP_ID` environment varialbe by replacing `{{YOUR_WIP_ID}}`:
```bash
export WIP_ID={{YOUR_WIP_ID}}
export PROVIDER_ID=github-provider
```

Then run:
```bash
gcloud iam workload-identity-pools undelete $WIP_ID --location=global
```

`cd` into where your wip unit is:
```bash
cd .terragrunt-stack/workload_identity_federation/
```

The wip unit can be deeper in the tree if you use `stacks`:
```bash
cd .terragrunt-stack/enable_tg_github_actions/.terragrunt-stack/workload_identity_federation
```

Declare the `PROJECT_NUMBER` variable:
```bash
export PROJECT_NAME=$(gcloud config get-value project)
```

Import the pool into Terraform state:
```bash
terragrunt import google_iam_workload_identity_pool.github_pool projects/$PROJECT_NAME/locations/global/workloadIdentityPools/$WIP_ID

terragrunt import google_iam_workload_identity_pool_provider.github projects/$PROJECT_NAME/locations/global/workloadIdentityPools/$WIP_ID/providers/$PROVIDER_ID
```

Go back to the root of your stack and run:
```bash
cd ../..
terragrunt stack run apply
```

If your still stuck, use another `google_iam_workload_identity_pool` ID.

## Module Details

This stack instantiates four Terraform modules that work together to run Terragrunt with GitHub Actions.

### 1. APIs Module
**What**: Enables required GCP services (IAM, Cloud Resource Manager, STS, Compute)

**Why**: Foundation services must be active before creating resources  

### 2. Workload Identity Federation (WIF)
**What**: Creates [OIDC](http://docs.github.com/en/actions/concepts/security/openid-connect) trust between GitHub Actions and GCP.

**Why**: Allows GitHub Actions to authenticate to GCP without storing service account keys.

**Interactions**:
- Creates the service account and identity pool that GitHub Secrets will reference
- Only allows authentication from GitHub Actions running in your specified repository 

### 3. GitHub Secrets
**What**: Stores WIF credentials as GitHub Actions secrets

**Why**: Provides GitHub Actions workflows with the identity information needed to authenticate to GCP

**Interaction**: 
- Depends on WIF to get the provider name and service account email
- These secrets are used in GitHub Actions workflows for authentication

### 4. Deploy Key
**What**: Generates SSH deploy key for repository access.

**Why**: Enables Terragrunt to pull code from private repositories during multi-repo deployments.

**Interaction**: 
- Adds public key to target repositories
- Stores private key as GitHub secret for use in the CI (`webfactory/ssh-agent` github action)