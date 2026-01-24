{ config, pkgs, lib, nixpkgs, ... }:

{
  imports = [
    "${nixpkgs}/nixos/modules/installer/iso-image.nix"
    ./base.nix
    ../../shared/desktop/fonts.nix
  ];
  isoImage.edition = "graphical";
  isoImage.showConfiguration = lib.mkDefault false;

  specializsations.plasma.configurations = {
    imports = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
      ../../shared/desktop/kde-plasma.nix
      ../../shared/vscode/main.nix
    ];
    isoImage.showConfiguration = true;
    isoImage.configurationName = "Plasma (Linux ${config.boot.kernelPackages.kernel.version})";
  };
}