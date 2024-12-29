# This Nix file contains the Tailscale configuration here
# in NixOS, mostly on the side of the daemon and its related
# configurations.

{ config, pkgs, lib, ... }:

{
  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
    openFirewall = true;
    disableTaildrop = false;
    extraDaemonFlags = [
      "--verbose 3"
    ];
  };
}