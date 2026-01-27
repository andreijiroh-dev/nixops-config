{ config, pkgs, lib, nixpkgs, ... }:

{
  imports = [
    ./base.nix
  ];
  isoImage.edition = "graphical";

  specialisation.plasma.configuration = {
    imports = [
      ../../shared/appimages.nix
      ../../shared/1password.nix
      ../../shared/desktop/fonts.nix
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
      ../../shared/desktop/kde-plasma.nix
      ../../shared/desktop/firefox.nix
      ../../shared/vscode/main.nix
    ];
    isoImage.configurationName = "Plasma (Linux ${config.boot.kernelPackages.kernel.version})";
  };
}