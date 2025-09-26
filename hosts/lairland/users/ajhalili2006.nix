{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../shared/home-manager/main.nix
  ];

  home.username = "ajhalili2006";
  home.homeDirectory = "/home/ajhalili2006";
}
