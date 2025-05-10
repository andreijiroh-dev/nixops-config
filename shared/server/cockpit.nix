{ pkgs, ... }:

{
  services.cockpit = {
    enable = true;
    package = pkgs.cockpit;
    #allowed-origins = [];
  };
}