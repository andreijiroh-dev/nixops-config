{ pkgs, config, ... }:

# Nix configurations for flatpaks

{
  # enable both flatpak and the builder
  config = {
    services.flatpak.enable = true;
    environment.systemPackages = [ pkgs.flatpak-builder ];

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
