{ pkgs, ... }:

{
  imports = [
    ./firefox.nix # firefox and friends go here
  ];

  environment.systemPackages = with pkgs; [
    google-chrome
    # Commented out MS Edge due to sync issues with M365 school accounts atm
    #microsoft-edge
    vivaldi
  ];
}