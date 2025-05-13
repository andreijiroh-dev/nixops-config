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

    # git tools
    gitFull
    gh
    glab
    fjo
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

  system.nixos.tags = [ "with-containers" "with-qemu" "with-devtools-enabled"];
}
