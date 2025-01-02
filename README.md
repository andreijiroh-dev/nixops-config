# `@andreijiroh-dev/nixops-config`

This is @ajhalili2006's NixOS + Home Manager configuration for his laptop
and homelabs, in sync with the [nixpkgs-specific dotfiles repository].

[nixpkgs-specific dotfiles repository]: https://github.com/andreijiroh-dev/dotfiles/tree/nixpkgs

## CI Status

| Workflow Name and Type | CI Platform | Badge/Link |
| --- | --- | --- |
| Nix Flake Builds (push) | GitHub Actions | [![Nix Flake Builds](https://github.com/andreijiroh-dev/nixops-config/actions/workflows/update-flakes.yml/badge.svg)](https://github.com/andreijiroh-dev/nixops-config/actions/workflows/update-flakes.yml) |
| Nix Flake Builds (schedule, every 06:30 UTC Saturday) | GitHub Actions | [![Nix Flake Builds](https://github.com/andreijiroh-dev/nixops-config/actions/workflows/update-flakes.yml/badge.svg?event=schedule)](https://github.com/andreijiroh-dev/nixops-config/actions/workflows/update-flakes.yml) |

## Usage

### Installing NixOS

It is recommended to install NixOS using either the Calamares-based graphical
installer or manually through the `nixos-install` utility, especially
when you have consider partitioning on your drive to ensure that you can roll back
safely in case things go wrong.

After installation, proceed with the steps in updating configuration below.

### Updating configuration or upgrading NixOS system

```bash
EDITOR="nano" # or code if you do
$EDITOR <path/to/nixfile.nix>

# update the flake.lock file manually
nix flake update

# change {hostname} to something like stellapent-cier
sudo nixos-rebuild --flake github:andreijiroh-dev/nixops-config#{hostname} <switch|boot|build>
```

**From a local copy**:

```bash
# update the flake.lock file manually
nix flake update

# change {hostname} to something like stellapent-cier
sudo nixos-rebuild --flake .#{hostname} <switch|boot|build>
```

### Building a minimial ISO for recovery

Currently available as `amd64` (`x86-64`) Linux ISO only for now.

```bash
# Build using the sources as remote
nix build github:andreijiroh-dev/nixops-config/main#nixosConfigurations.recoverykit-amd64.config.system.build.isoImage

# ...or via a local clone
nix build .#nixosConfigurations.recoverykit-amd64.config.system.build.isoImage
```

## License

MPL-2.0
