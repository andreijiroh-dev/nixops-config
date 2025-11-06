{ config, pkgs, lib, zen-browser, ... }:

{
  # This now configures the 'gildedguy' user within the NixOS module system
  home-manager.users.gildedguy = {
    imports = [
      ../../../shared/home-manager/main.nix
      zen-browser.homeModules.beta
    ];

    home.username = "gildedguy";
    home.homeDirectory = "/home/gildedguy";
  };
}