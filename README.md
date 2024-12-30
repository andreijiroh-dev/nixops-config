# `@andreijiroh-dev/nixops-config`

This is @ajhalili2006's NixOS + Home Manager configuration for his laptop
and homelabs, in sync with the [nixpkgs-specific dotfiles repository].

[dotfiles repository]: https://github.com/andreijiroh-dev/dotfiles/tree/nixpkgs

## Usage

### Updating or installing NixOS

```bash
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

## License

MPL-2.0
