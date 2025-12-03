# This NixOS configuration is for the custom recovery/installation media
# using the minimal image here, probably built on GitHub Actions.

{
  lib,
  nixpkgs,
  self,
  nix4vscode,
  ...
}:

{
  imports = [
    ../../shared/systemd.nix
    ../../shared/server/ssh.nix
    ../../shared/nix.nix
    ../../shared/systemd.nix
  ];

  # Import my SSH keys to the nixos user for remote access.
  config = {
    users.users.nixos = {
      openssh = {
        authorizedKeys.keys = with import ../../shared/ssh-keys.nix; [
          personal.y2022
          personal.passwordless
          rp.gildedguy
          work.recaptime-dev.crew
        ];
      };
    };
  };
}
