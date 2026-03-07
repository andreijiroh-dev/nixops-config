# To use this shared NixOS configuration for OpenSSH, just import this file
# on your NixOS configuration.

{
  config,
  pkgs,
  lib,
  ...
}:

{
  services.openssh = {
    enable = true;
    settings = {
      # Disable password authentication over SSH and require SSH keys
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false;

      # Allow port and X11 forwarding
      AllowTcpForwarding = true;
      X11Forwarding = true;

      Macs = [
        "hmac-sha2-512-etm@openssh.com"
        "hmac-sha2-256-etm@openssh.com"
        "umac-128-etm@openssh.com"
        "hmac-sha2-256" # required for Cloudflare Access SSH via Browser Rendering
      ];
    };
  };

  programs.mosh.enable = true;

  # disable hibernation and hybrid sleep
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

}
