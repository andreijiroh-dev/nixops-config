{ config, pkgs, lib, zen-browser, dev-pkgs, ... }:

{
  # Might be obvious to some since I'm technically roleplaying on my
  # old HP laptop my overseas Filipino dad gave me in 2024.
  users.users.gildedguy = {
    isNormalUser = true;
    description = "Gildedguy (Michael Moy)"; # We're not impersonating the animatior here lol.
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    openssh = {
      authorizedKeys.keys = with import ../../../shared/ssh-keys.nix;; [
        personal.y2022
        personal.passwordless
        personal.campus-comlab
        work.recaptime-dev.crew
        rp.gildedguy
      ];
    };
    linger = true;
  };

  home-manager.users.gildedguy = {
    imports = [
      zen-browser.homeModules.beta
      ../../../shared/home-manager/main.nix
    ];

    home.username = "gildedguy";
    home.homeDirectory = "/home/gildedguy";
  };
}