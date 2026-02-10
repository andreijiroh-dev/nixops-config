{ pkgs, ... }:

{
  environment.defaultPackages = with pkgs; [
    # nix utils
    direnv
    cachix
    devbox
    nixfmt-rfc-style
    nil
    nixd

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
    #dotenvx

    # genai tools
    llm-agents.gemini-cli
    llm-agents.copilot-cli
    llm-agents.amp
    llm-agents.agent-deck
    llm-agents.backlog-md
    llm-agents.coderabbit-cli
  ];

  virtualisation = {
    # containers
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

    # libvirtd
    libvirtd = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  # enable direnv integration for shells
  programs.direnv.enable = true;

  system.nixos.tags = [
    "devtools"
  ];
}
