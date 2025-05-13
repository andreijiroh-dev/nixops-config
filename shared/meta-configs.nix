# This is the meta config file for nixpkgs and nix cli itself, including
# trusted keys for cachix caches.

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
    gc = {
      automatic = true;
      randomizedDelaySec = "30min";
    };
    settings = {
      # See https://nix.dev/manual/nix/latest/development/experimental-features
      # for latest supported feature flags.
      experimental-features = [
        "auto-allocate-uids"
        "ca-derivations"
        "cgroups"
        "configurable-impure-env"
        "daemon-trust-override"
        "dynamic-derivations"
        "fetch-closure"
        "fetch-tree"
        "flakes"
        "git-hashing"
        "impure-derivations"
        "local-overlay-store"
        "mounted-ssh-store"
        "nix-command"
        "no-url-literals"
        "parse-toml-timestamps"
        "pipe-operators"
        "read-only-local-store"
        "recursive-nix"
        "verified-fetches"
      ];

      trusted-users = [
        "root"
        "gildedguy"
        "ajhalili2006"
        "nixos"
      ];

      # just sync with trusted-users, but w/o root
      allowed-users = [
        "gildedguy"
        "ajhalili2006"
        "nixos"
      ];

      trusted-public-keys = [
        # cache.nixos.org
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        # nix-community
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="

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
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://andreijiroh-dev.cachix.org"
        "https://ajhalili2006-nixos-builds.cachix.org"
        "https://recaptime-dev.cachix.org"
      ];
    };
  };

  # Needed since Determinate Nix manages the main config file for system.
  environment.etc."nix/nix.custom.conf" = {
    source = ../misc/nix/nix.custom.conf;
    mode = "0644";
  };
}
