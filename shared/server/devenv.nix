{ pkgs, ... }:

{
  environment.defaultPackages = with pkgs; [
    # nix utils
    direnv
    cachix
    devbox
    nixfmt-rfc-style

    # tmux and friendos
    byobu
    tmux
    htop
    btop

    # git tools
    gitFull
    gh
    glab
    fjo

    # other utils
    wakatime-cli
    doppler
    dotenvx
  ];

  virtualisation = {
    podman = {
      enable = true;
      package = pkgs.podman;
      extraPackages = with pkgs; [
        gvisor
        podman-compose
      ];
    };
    docker = {
      enable = true;
      enableOnBoot = true;
      daemon = {
        settings = {
          dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
          #ipv6 = true;
        };
      };
    };
    libvirtd = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  system.nixos.tags = [ "containers-and-vms" "devtools"];
}
