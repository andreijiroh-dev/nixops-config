# To use this shared NixOS configuration for OpenSSH, just import this file
# on your NixOS configuration.

{
  config,
  pkgs,
  lib,
  self,
  ...
}:

let
  caCerts = with import ../ssh-keys.nix; infra.ca_certs;
in
{
  imports = [
    #"${self}/shared/options.nix"
  ];
  config = {
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

          # required for Cloudflare Access SSH via Browser Rendering
          "curve25519-sha256@libssh.org"
          "curve25519-sha256"
          "ecdh-sha2-nistp256"
          "ecdh-sha2-nistp384"
          "ecdh-sha2-nistp521"
          "hmac-sha2-256"

        ];

        TrustedUserCAKeys = "${pkgs.writeText "cloudflare-ca.pub" ''
          ${caCerts.cfAccessForInfra.ajhalili2006}
          ${caCerts.cfAccessForInfra.recaptime-dev}
        ''}";
      };
    };
    # Enable OpenSSH agent on login
    # https://search.nixos.org/options?channel=unstable&query=programs.ssh.&show=programs.ssh.startAgent
    programs.ssh.startAgent = true;

    # mosh support
    programs.mosh.enable = true;

    # disable hibernation and hybrid sleep
    systemd.targets.hibernate.enable = false;
    systemd.targets.hybrid-sleep.enable = false;
  };
}
