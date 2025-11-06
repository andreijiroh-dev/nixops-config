{ config, pkgs, lib, zen-browser, ... }:

{
  # see ../../stellapent-cier/users/gildedguy.nix for context
  home-manager.users.ajhalili2006 = {
    imports = [
      ../../../shared/home-manager/main.nix
      zen-browser.homeModules.beta
    ];

    home.username = "ajhalili2006";
    home.homeDirectory = "/home/ajhalili2006";
  };
}