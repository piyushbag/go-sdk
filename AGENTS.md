# AGENTS.md

## Project Overview

This repository contains the official Go SDK for the Model Context Protocol (MCP).
The SDK is designed to be idiomatic, future-proof, and extensible.

### Key Packages

-   `mcp`: The core package defining the primary APIs for constructing and using MCP clients and servers. This is where most logic resides.
-   `jsonrpc`: Provides the JSON-RPC 2.0 transport layer. Use this if implementing custom transports.
-   `auth`: Primitives for supporting OAuth.
-   `oauthex`: Extensions to the OAuth protocol, such as Protected Resource Metadata.
-   `internal`: Internal implementation details not exposed to users.
-   `examples`: Example clients and servers. Use these as references for usage patterns.

## Development Setup

The project uses the standard Go toolchain.

-   **Build**: `go build ./...`
-   **Test**: `go test ./...`

## Testing

-   **Unit Tests**: Run `go test ./...` to run all unit tests.
-   **Conformance Tests**: Use the following scripts to run the official MCP conformance tests against the SDK.
    -   `./scripts/server-conformance.sh` for server tests.
    -   `./scripts/client-conformance.sh` for client tests.
    -   The scripts download the latest conformance suite from npm by default.
    -   To get possible options pass the `--help` flag to the script.

## Development Guidelines

### Code Style

-   Follow standard Go conventions (Effective Go).
-   Use `gofmt` to format code.
-   Add copyright headers to all new Go files:
    ```go
    // Copyright 2025 The Go MCP SDK Authors. All rights reserved.
    // Use of this source code is governed by the license
    // that can be found in the LICENSE file.
    ```
-  Do not add comments to the code unless they are really necessary:
    -   Prefer self-documenting code.
    -   Focus on the "why" not the "what" in comments.

### Documentation

-   **README.md**: Do NOT edit `README.md` directly. It is generated from `internal/readme/README.src.md`.
    -   Edit `internal/readme/README.src.md`.
    -   Run `go generate ./internal/readme` to regenerate.
    -   Commit both files.
-   **docs/**: Do NOT edit `docs/` directory directly. It is generated from files in `internal/docs`.
    -   Edit `internal/docs/*.src.md`.
    -   Run `go generate ./internal/docs` to regenerate.
    -   Commit files from both directories.

## Cursor Cloud specific instructions

- This is a pure Go module (no application binary to "deploy"); the products are library packages plus runnable example/conformance commands under `examples/` and `conformance/`. Dependencies come from the Go module cache; the startup update script runs `go mod download`.
- CI lint (`.github/workflows/test.yml`) is `gofmt -l .`, `go vet ./...`, and `staticcheck` (`honnef.co/go/tools/cmd/staticcheck@v0.6.1`). `staticcheck` is not vendored; install it on demand with `go install honnef.co/go/tools/cmd/staticcheck@v0.6.1` and run `$(go env GOPATH)/bin/staticcheck ./...`.
- Quick end-to-end sanity check of MCP over HTTP: run `go run ./examples/http server` in one terminal, then `go run ./examples/http client` in another. The client lists tools and calls `cityTime`. Note: a plain GET to the server root returns HTTP 400 by design (it is an MCP streamable endpoint, not a browser page), so don't treat that as a failure.
- The conformance scripts (`./scripts/server-conformance.sh`, `./scripts/client-conformance.sh`) shell out to `npx @modelcontextprotocol/conformance@latest`, so they require Node/npx and network access to npm.
- CRITICAL — bot accounts are not allowed in this public repo. NEVER let `cursor[bot]` (or any bot account) push to it. By default a fresh Cloud Agent VM points `origin` at the Cursor GitHub App token (`https://x-access-token:...@github.com/...`), so any `git push` is attributed to `cursor[bot]` in the PR timeline — which is not acceptable here and has caused PRs to be closed by maintainers. Before pushing to any branch, re-point `origin` to push as the human author using their personal access token, e.g. `git remote set-url origin "https://<user>:<PAT>@github.com/<user>/<repo>"`, and set `git config user.name`/`user.email` to the human author. Verify the pusher is the human (not a bot) before and after pushing. GitHub force-push/timeline events are immutable and cannot be deleted afterward, so the only remedy for a bot-tainted PR is opening a fresh PR pushed entirely by the human — so get this right up front, every session.
