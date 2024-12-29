# This is the meta config file for nixpkgs and nix cli

{ config, pkgs, lib, ... }:

{
  # Adopted from https://fnordig.de/til/nix/home-manager-allow-unfree.html,
  # but we'll also enable it system-wide too.
  nixpkgs = {
    config = {
      allowUnfree = true;
      # https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}