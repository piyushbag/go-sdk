# Cloud Agent environment

This directory configures [Cursor Cloud Agents](https://cursor.com/docs/cloud-agent/setup) for this fork.

## What runs automatically

On each agent startup, `.cursor/scripts/cloud-agent-install.sh` (via `environment.json`) sets:

- Git author/committer to **Piyush Jagadish Bag** `<piyushbag4@gmail.com>`
- `commit.gpgsign=false` (avoids Cursor Agent SSH signatures)
- `gh auth login` when `CURSOR_GH_PAT` is present
- `go mod download` (idempotent dependency warmup)

## Dashboard secrets (recommended)

In [Cloud Agents → your environment → Secrets](https://cursor.com/dashboard/cloud-agents):

| Secret | Purpose |
|--------|---------|
| `CURSOR_GH_PAT` | Fine-grained GitHub PAT with Contents, Pull requests, and Issues (read/write). Enables `gh pr comment`, `gh pr create`, etc. under your account. |

Optional overrides:

| Secret | Default |
|--------|---------|
| `GIT_USER_NAME` | `Piyush Jagadish Bag` |
| `GIT_USER_EMAIL` | `piyushbag4@gmail.com` |

## Commits from agents

Agents must use the wrapper so commits are not attributed to Cursor Agent:

```bash
.cursor/scripts/git-commit.sh -m "your message"
```

This skips the Cursor co-author hook and disables GPG signing with the agent key.

## Cursor Desktop

Turn off **Settings → Agent → Attribution** if you do not want co-author trailers on local agent commits either.
