{ pkgs, nixpkgs, lib, config, ... }:

{
  import = [
    ../../shared/nix.nix
    ../../shared/gnupg.nix
    ../../shared/locale.nix
    ../../shared/networking.nix
    ../../shared/systemd.nix
    ../../shared/shells/bash.nix
    ../../shared/shells/custom-prompts.nix
    ../../shared/1password.nix
    ../../shared/vscode/server.nix
    ../../shared/server/ssh.nix
    ../../shared/server/tailscale.nix
    "${nixpkgs}/nixos/modules/installer/iso-image.nix"
    "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${nixpkgs}/nixos/modules/installer/cd-dvd/latest-kernel.nix"
  ];
  isoImage.showConfiguration = lib.mkDefault false;
  isoImage.configurationName = lib.mkDefault "(Linux ${config.boot.kernelPackages.kernel.version})";

  networking = {
    hostname = "multichaos-livecd";
    networkmanager.enable = true;
  };

  # Enable sshd by default here
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];

  # Some of them are from different shared configs, but tweaked for general use
  # in the Live CD setup.
  environment.defaultPackages = with pkgs; [
    # nix utils
    direnv
    cachix
    devbox
    nixfmt-rfc-style
    nil
    nixd

    # git tools
    gitFull
    gh
    glab
    fjo

    # other utils
    wakatime-cli
    doppler
    dotenvx

    # system utils
    neofetch
    fastfetch
  ];

  config = {
    users.users.nixos = {
      openssh = {
        authorizedKeys.keys = with import ../../shared/ssh-keys.nix; [
          personal.y2022
          personal.passwordless
          personal.rp.gildedguy
          work.recaptime-dev.crew
        ];
      };
    };
  };

  services.tailscale.extraDaemonFlags = [
    "--verbose=3"
    "--state=mem:"
  ];
}