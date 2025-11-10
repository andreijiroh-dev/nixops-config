{ config, pkgs, lib, ... }:

{
  users.users.ajhalili2006 = {
    isNormalUser = true;
    description = "Andrei Jiroh Halili";
    extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
    ];
    openssh.authorizedKeys.keys = with import ../../../shared/ssh-keys.nix; [
        personal.y2022
        personal.passwordless
        personal.campus-comlab
        work.recaptime-dev.crew
        personal.rp.gildedguy
      ];
    linger = true;
  };
  
  # see ../../stellapent-cier/users/gildedguy.nix for context
  home-manager.users.ajhalili2006 = {
    imports = [
      ../../../shared/home-manager/nogui.nix
    ];

    home.username = "ajhalili2006";
    home.homeDirectory = "/home/ajhalili2006";
  };
}
