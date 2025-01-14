{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Yubikey
  services.yubikey-agent.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
}