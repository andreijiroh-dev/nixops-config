{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Yubikey
  services.yubikey-agent.enable = true;
  services.udev.packages = with pkgs; [
    yubikey-personalization
    yubikey-manager
    age-plugin-yubikey
  ];
}
