This repository contains NixOS and Home Manager configurations for various machines. The goal is to manage system and user configurations declaratively using Nix.

### Project Structure

The repository is structured as a Nix flake.

- `flake.nix`: The main entry point. It defines the flake's inputs (like `nixpkgs`, `home-manager`, etc.) and outputs. The main outputs are `nixosConfigurations` for NixOS hosts and `homeConfigurations` for home-manager configurations on both NixOS and non-NixOS hosts.
- `hosts/`: Contains the configurations for specific machines. Each subdirectory corresponds to a host and contains a `configuration.nix` file, which is the main configuration for that host.
    - `hosts/<hostname>/configuration.nix`: The main configuration for the host itself.
    - `hosts/<hostname>/hardware-configuration.nix`: Host-specific hardware configurations like the bootloader, kernel, and hardware options.
    - `hosts/<hostname>/users/<username>.nix`: User-specific settings, including any home-manager configurations that's separate from the shared home-manager configuration at `shared/home-manager/`.
    - Note that `hosts/live-cd/` is a special host configuration for building custom NixOS live CD images, primarily built via GitHub Actions and used for setting up NixOS on a fresh host and recovery tooling and uses a separate structure from a regular host configuration with `hosts/live-cd/base.nix` as the base configuration and each variant has its own Nix file (e.g. `hosts/live-cd/kde-plasma.nix` for the KDE Plasma-based live CD image).
- `shared/`: Contains modules that are shared across different hosts. This is where most of the configuration logic resides.
    - `shared/desktop/`: Desktop specifics (Bluetooth, KDE Plasma, Firefox, Yubikey integration, etc.).
    - `shared/server/`: Server-side configurations (SSH server, Firewall, Tailscale, Cockpit).
    - `shared/home-manager/`: Home Manager configurations for user-specific dotfiles and packages.
    - `shared/options`: custom NixOS options under the `nixops-config` namespace for custom tooling
    - `shared/shells/`: Shell configurations (Bash, custom prompts).
    - `shared/vscode/`: VS Code related settings like extensions, binary fixes for Remote SSH/Tunnel and others.
- `pkgs/`: Custom packages defined in this flake (e.g., `coolify-compose`, `detect-vscode-for-git`).
- `scripts/`: Helper scripts for deployment and maintenance.
- `secrets/`: agenix-managed encrypted secrets, used during NixOS config rebuilds. Uses the [`agenix-rekey`](https://github.com/oddlama/agenix-rekey) extension to avoid the headaches of managing `secrets.nix` manually and doing the rekeying dance. DO NOT TOUCH THIS DIRECTORY!
- `misc/`: Miscellaneous configurations and library scripts that may imported or referenced in Nix files (e.g., [starship configuration](https://starship.rs/config/), bash helper functions, age-formatted pubkeys, etc.).

### Key Concepts

- **NixOS Modules**: The configurations are built using the NixOS module system. The `shared/` directory contains many reusable modules. When you need to add or change a configuration, you'll likely be editing one of these files or creating a new one.
- **Home Manager**: Home Manager is used to manage user-level configurations (dotfiles, packages, services). The main Home Manager configuration is in `shared/home-manager/main.nix`.
- **Flake Outputs**:
    - `nixosConfigurations`: System configurations for hosts.
    - `homeConfigurations`: Standalone Home Manager configurations.
    - `packages`: Custom packages exported by this flake.
    - `overlays`: Nixpkgs overlays to make custom packages available to system configurations.
    - `exportedConfigs`: Reusable modules exported for external consumers of the flake.

### Developer Workflow

#### Adding a new host

1.  Create a new directory in `hosts/` for the new host.
2.  Add a `configuration.nix` file inside the new directory. You can use one of the existing host configurations as a template.
3.  Add a new entry to the `nixosConfigurations` in `flake.nix` for the new host, pointing to your new `configuration.nix`.
4.  Import the necessary shared modules into your `configuration.nix`.

#### Modifying a configuration

1.  Identify which module or host configuration you need to change.
2.  Make your changes to the respective `.nix` file.
3.  To apply the changes to a machine, run `sudo nixos-rebuild switch --flake .#<hostname>` on that machine, where `<hostname>` is the name of the host you want to update.

#### Updating dependencies

To update the flake's inputs (e.g., `nixpkgs`), run:

```bash
nix flake update
```

This will update the `flake.lock` file with the latest versions of the dependencies.

### Important Files

- `flake.nix`: The central point of the configuration.
- `shared/meta.nix`: Imports a base set of shared modules.
- `shared/home-manager/main.nix`: The main entry point for user-specific configurations managed by Home Manager.
- `shared/home-manager/nogui.nix`: A headless Home Manager configuration (used in `plain` configs).
- `hosts/<hostname>/configuration.nix`: The main configuration file for a specific host.
- `hosts/<hostname>/users/<username>.nix`: User-specific configurations for a given host, leveraging Home Manager. See `hosts/stellapent-cier/users/gildedguy.nix` for an example.
- `hosts/live-cd/base.nix` and `hosts/live-cd/kde-plasma.nix`: Live CD-specific NixOS configurations

When working on this codebase, remember that it's all about declarative configuration. Instead of changing things imperatively on the system, you declare the desired state in these `.nix` files, and Nix takes care of making it happen.
