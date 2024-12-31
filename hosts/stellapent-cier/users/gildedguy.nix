{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../shared/home-manager/main.nix
  ];

  config = {
    home.username = "gildedguy";
    home.homeDirectory = "/home/gildedguy";
  };
}