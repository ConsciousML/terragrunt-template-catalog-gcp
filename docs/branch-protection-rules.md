Get your repository url:
```bash
REPO=$(gh repo view --json nameWithOwner --jq .nameWithOwner)
```

If you are in a team and require approval on your PRs:
```bash
gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/$REPO/branches/main/protection \
  --input protection_rules/main_rules_with_approval.json
```

If you code alone and want to disable approvals on PR:
```bash
gh api \
  --method PUT \
  -H "Accept: application/vnd.github+json" \
  /repos/$REPO/branches/main/protection \
  --input protection_rules/main_rules_no_approval.json
```