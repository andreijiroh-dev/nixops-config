{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./firefox.nix
    ./firewall.nix
    ./fonts.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    thunderbird

    # browsers (firefox is in ./firefox.nix)
    google-chrome
    microsoft-edge

    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    
    # android tools
    android-tools
    adbtuifm
  ];
}