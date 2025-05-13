{ pkgs, ... }:

{
  services.cockpit = {
    enable = true;
    package = pkgs.cockpit;
    #allowed-origins = [];
  };

  system.nixos.tags = [ "with-cockpit" ];
}