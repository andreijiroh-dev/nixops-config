{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./browsers.nix
    ./firewall.nix
    ./fonts.nix
    ./yubikey.nix
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    thunderbird

    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US

    # android tools
    android-tools
    adbtuifm

    #termius
  ];
}
