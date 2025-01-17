# To use this shared NixOS configuration for OpenSSH, just import this file
# on your NixOS configuration.

{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      # Disable password authentication over SSH and require SSH keys
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = "no";

      # Allow port and X11 forwarding
      AllowTcpForwarding = "yes";
      X11Forwarding = "yes";
    };
  };

  programs.mosh.enable = true;
}