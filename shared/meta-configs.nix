# This is the meta config file for nixpkgs and nix cli itself, including
# trusted keys for cachnix caches

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

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "repl-flake"
        "ca-derivations"
        "cgroups"
        "impure-derivations"
        #"daemon-trust-override"
        #"auto-allocate-uids"
      ];

      trusted-users = [
        "root"
        "gildedguy"
        "ajhalili2006"
      ];

      # just sync with trusted-users, but w/o root
      allowed-users = [
        "gildedguy"
        "ajhalili2006"
      ];

      trusted-public-keys = [
        # devenv.sh
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="

        # my caches for nixos and nixpkgs related builds (including devenvs)
        "ajhalili2006-nixos-builds.cachix.org-1:fA8HXvGR1i792D+CxL2iW/TQzUcyoW7zPUmC9Q4mQLg="

        # the main cache itself
        "andreijiroh-dev.cachix.org-1:7Jd0STdBOLiNu5fiA+AKwcMqQD2PA1j9zLDGyDkuyBo="

        # recaptime.dev cache
        "recaptime-dev.cachix.org-1:b0UBO1zONf6ceTIoR06AKhgid4ZOl5kxB/gOIdZ9J6g="
      ];

      # also list them all too
      trusted-substituters = [
        "https://devenv.cachix.org"
        "https://andreijiroh-dev.cachix.org"
        "https://ajhalili2006-nixos-builds.cachix.org"
        "https://recaptime-dev.cachix.org"
      ];
    };
  };
}
