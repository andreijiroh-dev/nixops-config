{ config, pkgs, lib, ... }:

{
  # Open ports in the firewall.
  networking.firewall.allowedTCPPortRanges = [
    { from = 1714; to = 1764; } # used by KDE Connect
    { from = 3000; to = 3999; }
    { from = 8000; to = 8999; }
  ];
  networking.firewall.allowedUDPPortRanges = [
    { from = 1714; to = 1764; } # used by KDE Connect
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