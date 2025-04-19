{ pkgs, ... }:

{
  imports = [
    ./git.nix
    ./packages.nix
    ./shell.nix
  ];

  # let hm install and manage itself
  programs.home-manager.enable = true;

  # check docs before bumping this
  home.stateVersion = "24.11";
}