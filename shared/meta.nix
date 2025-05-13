# One Nix file to import all the base configs without cluttering the per-host
# imports.
{ ... }:

{
  imports = [
    ./meta-configs.nix
    ./flatpak.nix
    ./gnupg.nix
    ./locale.nix
    ./networking.nix
    ./systemd.nix
    ./shells/bash.nix
  ];
}