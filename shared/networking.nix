{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Do a lot of systemd-resolved related chores
  networking.nameservers = [
    "45.90.28.0#c393f6.dns.nextdns.io"
    "45.90.30.0#c393f6.dns.nextdns.io"
  ];

  # systemd-resolved related settings
  boot.initrd.services.resolved.enable = true;
  services.resolved.enable = true;
  services.resolved.settings.Resolve = {
    DNSSEC = "false"; # https://superuser.com/a/1493674
    # Commented this out since Tailscale do thee heavy work for MagicDNS
    #domains = [ "~." "fawn-cod.ts.net" ];
    # Use Cloudflare DNS resolver as fallback if things go wrong.
    FallbackDNS = [
      "172.64.36.1#y24o2ptvff.cloudflare-gateway.com"
    ];
    DNSOverTLS = "true";
  };

  networking.networkmanager.wifi.powersave = false;
}
