{ config, pkgs, lib, zen-browser, ... }:

{
  imports = [
    ../../../shared/home-manager/main.nix
    zen-browser.homeModules.beta
  ];

  home.username = "ajhalili2006";
  home.homeDirectory = "/home/ajhalili2006";
}
