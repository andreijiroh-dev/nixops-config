# Firebase Studio configuration

This directory holds the Firebase Studio (formerly Project IDX) dev environment
configuration for this project.

## Key Files

- `dev.nix`: The primary configuration file for your Firebase Studio workspace. It defines the system packages, VS Code extensions, environment variables, and lifecycle hooks used in the environment.
- `dev.local.nix`: An optional, git-ignored file for making local-only adjustments to your workspace without affecting the shared configuration. It is automatically imported by `dev.nix` if it exists.

## Common Tasks

### Adding Packages

To add new system tools, search for the package name on [NixOS Package Search](https://search.nixos.org/packages) and add it to the `packages` list in `dev.nix`.

### Adding Extensions

To add VS Code extensions from the Open VSX marketplace, find the extension ID (usually in the format `publisher.extension-name`) and add it to the `idx.extensions` list in `dev.nix`.

## Features

- **Docker Support**: Docker is enabled by default in this workspace (`services.docker.enable = true`). `DOCKER_BUILDKIT` is also enabled for faster builds.

## Resources

- [Firebase Studio Documentation](https://firebase.google.com/docs/studio)
- [Firebase Studio Console](https://studio.firebase.google.com)
- [NixOS Package Search](https://search.nixos.org/packages)
