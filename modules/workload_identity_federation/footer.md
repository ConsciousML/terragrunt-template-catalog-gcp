## Resource Roles in GitHub Actions Authentication

- **Workload Identity Pool**: Central trust boundary that manages access for external identities (GitHub) to GCP resources
- **Workload Identity Pool Provider**: Establishes the trust relationship between GCP and GitHub's OIDC tokens, mapping GitHub claims to GCP attributes
- **Service Account**: Dedicated identity that GitHub Actions assumes to access GCP services with specific permissions
- **Workload Identity User Role**: Enables the external identity (GitHub repo) to impersonate the service account through the identity pool
- **Project IAM Members**: Grants the service account necessary permissions to perform infrastructure operations in the GCP project