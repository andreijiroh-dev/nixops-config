{ pkgs, ... }:

{
  config = {
    services.cockpit = {
      enable = true;
      package = pkgs.cockpit;
      #allowed-origins = [];
      plugins = with pkgs; [
        cockpit-files
        cockpit-podman
        cockpit-machines
        cockpit-zfs
      ];
    };

    system.nixos.tags = [ "cockpit" ];
  };
}