# Desktop apps and related configs go here in this Nix file
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-gui
    firefoxpwa
    kdePackages.krfb
    mysql-workbench
    remmina
  ];
}