# Configs for KDE Plasma DE and friends

{ config, pkgs, lib, ... }:

{
  imports = [
    ./base.nix
  ];

  config = {
    # Enable the KDE Plasma Desktop Environment.
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Also enable KDE Connect
    programs.kdeconnect.enable = true;

    # Manual override for pinentryPackage
    nixops-config.secretOps.gnupg.pinentryPkg = pkgs.pinentry-qt;

    environment.systemPackages = with pkgs; [
      kdePackages.krfb
      pinentry-qt
      kdePackages.kate
    ];
  };
}
