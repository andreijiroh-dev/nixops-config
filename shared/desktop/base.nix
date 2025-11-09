{ pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
    ./browsers.nix
    ./firewall.nix
    ./fonts.nix
    ./yubikey.nix
    ../flatpak.nix
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

    # workaround: https://discourse.nixos.org/t/need-help-with-resolving-missing-dependencies-for-auto-patchelf-on-termius/69722/2?u=ajhalili2006
    (pkgs.termius.overrideAttrs (oldAttrs: {
       buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.sqlite ];
    }))
  ];
}
