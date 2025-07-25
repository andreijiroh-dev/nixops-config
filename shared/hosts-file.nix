# An static list of host entries to be used in networking.hosts configuration.
# You probably want to use this inside a let...in block, see the example
# at ../hosts/stellapent-cier/configuration.nix for the hints.
{
  localhost = [
    "localhost"
    "localdev.andreijiroh.dev"
    "localdev.andreijiroh.eu.org"
  ];
  localNetwork = {
    halilifam = {
      "192.168.254.160" = [
        #"stellapent-cier"
        "stellapent-cier.local"
        "stellapent.local"
      ];
      "192.168.254.179" = [
        "rpi-aether.local"
        "aether.local"
      ];
    };
  };

  # hosts file for my Tailscale network, even with
  # MagicDNS disabled as a workaround.
  tailnet = {
    "100.87.227.94" = [
        "stellapent-cier"
        "stellapent-cier.tailnet"
        "stellapent-cier.fawn-cod.ts.net"
        "stellapent-cier.fawn-cod.tailnet"
        "stellapent"
        "stellapent.tailnet"
        "stellapent.tailnet.andreijiroh.dev"
        "stellapent.tailnet.andreijiroh.eu.org"
      ];
      "100.120.57.47" = [
        "rpi-aether"
        "rpi-aether.tailnet"
        "rpi-aether.tailnet.andreijiroh.dev"
        "rpi-aether.tailnet.andreijiroh.eu.org"
        "aether"
        "aether.tailnet"
        "aether.tailnet.andreijiroh.dev"
        "aether.tailnet.andreijiroh.eu.org"
      ];
      "100.102.205.81" = [
        "go"
        "go.tailnet"
        "go.fawn-cod.ts.net"
      ];
      "100.126.238.86" = [
        "paste"
        "paste.tailnet"
        "paste.fawn-cod.ts.net"
      ];
  };
}
