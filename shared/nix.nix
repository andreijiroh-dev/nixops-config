# This is the meta config file for nixpkgs and nix cli itself, including
# trusted keys for cachix caches and stateVersion for NixOS.

{
  config,
  pkgs,
  lib,
  self,
  nix4vscode,
  ...
}:

{
  # Adopted from https://fnordig.de/til/nix/home-manager-allow-unfree.html,
  # but we'll also enable it system-wide too.
  nixpkgs = {
    config = {
      allowUnfree = true;
      # https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
    overlays = [
      self.overlays.default
      nix4vscode.overlays.default
    ];
  };

  nix = {
    gc = {
      automatic = true;
      dates = [ "weekly" ];
      randomizedDelaySec = "30min";
    };
    settings = {
      # See https://nix.dev/manual/nix/latest/development/experimental-features
      # for latest supported feature flags.
      experimental-features = [
        "nix-command"
        "flakes"

        "auto-allocate-uids"
        "blake3-hashes"
        "ca-derivations"
        "cgroups"
        "configurable-impure-env"
        #"daemon-trust-override"
        "dynamic-derivations"
        "external-builders"
        "fetch-closure"
        "fetch-tree"
        "git-hashing"
        "impure-derivations"
        "local-overlay-store"
        "mounted-ssh-store"
        "no-url-literals"
        "pipe-operators"
        "read-only-local-store"
        #"recursive-nix"
        "verified-fetches"
      ];

      trusted-users = [
        "@wheel"
        "root"
        "gildedguy"
        "ajhalili2006"
        "nixos"
      ];

      # just sync with trusted-users, but w/o root
      allowed-users = [
        "@wheel"
        "gildedguy"
        "ajhalili2006"
        "nixos"
      ];

      trusted-public-keys = [
        # cache.nixos.org
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="

        # cache.flakehub.com
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "cache.flakehub.com-4:Asi8qIv291s0aYLyH6IOnr5Kf6+OF14WVjkE6t3xMio="
        "cache.flakehub.com-5:zB96CRlL7tiPtzA9/WKyPkp3A2vqxqgdgyTVNGShPDU="
        "cache.flakehub.com-6:W4EGFwAGgBj3he7c5fNh9NkOXw0PUVaxygCVKeuvaqU="
        "cache.flakehub.com-7:mvxJ2DZVHn/kRxlIaxYNMuDG1OvMckZu32um1TadOR8="
        "cache.flakehub.com-8:moO+OVS0mnTjBTcOUh2kYLQEd59ExzyoW1QgQ8XAARQ="
        "cache.flakehub.com-9:wChaSeTI6TeCuV/Sg2513ZIM9i0qJaYsF+lZCXg0J6o="
        "cache.flakehub.com-10:2GqeNlIp6AKp4EF2MVbE1kBOp9iBSyo0UPR9KoR0o1Y="

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
        "https://cache.flakehub.com"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://andreijiroh-dev.cachix.org"
        "https://ajhalili2006-nixos-builds.cachix.org"
        "https://recaptime-dev.cachix.org"
      ];
    };
  };

  # Needed since Determinate Nix manages the main config file for system.
  # Commented out for a while to test if it's really needed.
  #environment.etc."nix/nix.custom.conf" = {
  #  source = ../misc/nix/nix.custom.conf;
  #  mode = "0644";
  #};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # TODO: Always bump this to next point release once the current value is
  #       officially released to stable after reading the changelog.
  system.stateVersion = "25.11"; # Did you read the comment?
}
