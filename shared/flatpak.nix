# Nix configuration related to flatpaks

{ pkgs, ... }:

{
  # enable both flatpak and the builder
  services.flatpak.enable = true;
  environment.systemPackages = [ pkgs.flatpak-builder ];

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  system.nixos.tags = [ "with-flatpak" ];
}