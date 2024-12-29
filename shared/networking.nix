{ config, pkgs, lib, ... }:

{
  # Do a lot of systemd-resolved related chores
  config.networking.nameservers = [
    "45.90.28.0#c393f6.dns.nextdns.io"
    "45.90.30.0#c393f6.dns.nextdns.io"
  ];
  
  config.services.resolved = {
    enable = true;
    dnssec = "false"; # https://superuser.com/a/1493674
    domains = [ "~." "fawn-cod.ts.net" ];
    # Use Cloudflare DNS resolver as fallback if things go wrong.
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
    dnsovertls = "true";
  };
}