{ config, pkgs, lib, home-manager, ... }:

{
  imports = [
    ../../../shared/home-manager/main.nix
    zen-browser.homeModules.beta
  ];

  home.username = "gildedguy";
  home.homeDirectory = "/home/gildedguy";
}
