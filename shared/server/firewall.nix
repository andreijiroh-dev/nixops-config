{ config, pkgs, lib, ... }:

{
  networking.firewall.allowedTCPPortRanges = [
    { from = 3000; to = 3999; }
    { from = 8000; to = 8999; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 3000; to = 3999; }
    { from = 8000; to = 8999; }
  ];
  networking.firewall.allowedTCPPorts = [
    22
    80
    443
  ];
  networking.firewall.allowedUDPPorts = [
    22
    80
    443
  ];
}