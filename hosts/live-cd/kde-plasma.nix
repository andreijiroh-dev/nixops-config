{ config, pkgs, lib, nixpkgs, self, ... }:

{
  imports = [
    ./base.nix
  ];
  isoImage.edition = "graphical";

  specialisation.plasma.configuration = {
    imports = [
      "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
      "${self}/shared/desktop/kde-plasma.nix"
      "${self}/shared/vscode/main.nix"
    ];
    isoImage.configurationName = "Plasma (Linux ${config.boot.kernelPackages.kernel.version})";
  };
}