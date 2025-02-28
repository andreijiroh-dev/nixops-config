# `@andreijiroh-dev/nixops-config`

This is @ajhalili2006's NixOS + Home Manager configuration for his laptop and homelabs, in sync with the
[nixpkgs-specific dotfiles repository]. Also planned to be used in Hack Club Nest soon.

[nixpkgs-specific dotfiles repository]: https://gitlab.com/andreijiroh-dev/dotfiles/tree/nixpkgs

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

After installation, copy the generated NixOS configuration files from `/etc/nixos`
into a new directory named `hosts/<host-name>`. Note that on the rest of
the README, the placeholder `<host-name>` is used to denote the hostname of a new
or existing machine under Nix flake-based setup.

```bash
cp -rv /etc/nixos/ hosts/<host-name>/
```

On the `flake.nix` file, under the `nixosConfigurations` block, add the new host using the template below

```nix
<host-name> = nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    ./hosts/<host-name>/configuration.nix

    # load Determinate Nix and the rest
    determinate.nixosModules.default
    home-manager.nixosModules.home-manager
    vscode-server.nixosModules.default
    nix-ld.nixosModules.nix-ld

    # one-liners?
    { programs.nix-ld.dev.enable = true; }
  ];
};
```

Then on your `hosts/<host-name>/configuration.nix`, add the needed imports
as needed:

```nix
imports = [
  ./hardware-configuration.nix
  ../../shared/gnupg.nix
  ../../shared/meta-configs.nix
  ../../shared/server/ssh.nix
  ../../shared/server/tailscale.nix
  ../../shared/systemd.nix
  ../../shared/yubikey.nix
  # add more imports here
]
```

Adjust as needed before running a `nixos-rebuild switch` into the new configuration.

### Updating configuration or upgrading NixOS system

```bash
EDITOR="nano" # or code if you do
$EDITOR <path/to/nixfile.nix>
git stage <path/to/nixfile.nix>
git commit --signoff

# update the flake.lock file manually
nix flake update

# on the another machine...
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

### As an external flake module

You can easily use this flake as an external module in your own flake-based NixOS configuration
if you want to reuse some of my configurations.

```nix
{
  description = "My NixOS configuration";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/24.11";
  inputs.andreijiroh-dev.url = "github:andreijiroh-dev/nixops-config";
  # needed if you use stable instead of unstable
  inputs.andreijiroh-dev.inputs.nixpkgs.follows = "nixpkgs";

  # TODO: fix this soon
  outputs = { self, andreijiroh-dev, nixpkgs }: {
    let
      # change {hostname} to something like stellapent-cier
      # if you like to reuse my configs
      reusableConfig = andreijiroh-dev.nixosConfigurations.{hostname};
    in
    {
      nixosConfigurations.{hostname} = reusableConfig {
        # your customizations here
      };

      nixosConfigurations.your-mom = nixpkgs.lib.nixosSystem {
         system = "x86_64-linux";
         modules = [
          andreijiroh-dev.nixosModules.networking # or any other modules
         ];
      };
    };
}
```

### Building a minimial ISO for recovery

Currently available as `amd64` (`x86-64`) Linux ISO only for now, but you can copy
the `recoverykit-amd64` NixOS configuration and change `system` to any supported CPU
architectures by NixOS.

```bash
# Build using the sources as remote
nix build github:andreijiroh-dev/nixops-config/main#nixosConfigurations.recoverykit-amd64.config.system.build.isoImage

# ...or via a local clone
nix build .#nixosConfigurations.recoverykit-amd64.config.system.build.isoImage
```

## Availabled shared configs

- [`flatpak.nix`](./shared/flatpak.nix): NixOS for enabling Flatpaks
- [`gnupg.nix`](./shared/gnupg.nix): GnuPG configuration
- [`locale.nix`](./shared/locale.nix): Locale configuration
- [`meta-configs.nix`](./shared/meta-configs.nix): Meta configurations for the system, mostly related to Nix and nixpkgs.
- [`networking.nix`](./shared/networking.nix): Networking configuration, currently DNS resolver settings for `systemd-resolved`
- [`ssh-keys.nix`](./shared/ssh-keys.nix): SSH keys configuration as NixOS module, intended to be in sync with my keys on git forges
- [`server/devenv.nix`](./shared/server/devenv.nix): Development environment configuration, plus Docker and VM configurations.
- [`server/ssh.nix`](./shared/server/ssh.nix): SSH server configuration

## License

MPL-2.0
