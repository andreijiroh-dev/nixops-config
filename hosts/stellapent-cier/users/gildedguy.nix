{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../shared/home-manager/main.nix
  ];

  home.username = "gildedguy";
  home.homeDirectory = "/home/gildedguy";
}