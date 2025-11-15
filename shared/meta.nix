# One Nix file to import all the base configs without cluttering the per-host
# imports, alongside a minimal base packages.
{ pkgs, nix-ld, determinate, home-manager, vscode-server, ... }:

{
  # import configs first
  imports = [
    # nix flake modules first
    nix-ld.nixosModules.nix-ld
    determinate.nixosModules.default
    home-manager.nixosModules.home-manager
    vscode-server.nixosModules.default

    # then the configs
    ./1password.nix
    ./nix.nix
    ./appimages.nix
    ./gnupg.nix
    ./locale.nix
    ./networking.nix
    ./systemd.nix
    ./shells/bash.nix
    ./shells/custom-prompts.nix
    ./vscode/main.nix
  ];

  # and then the base packages itself
  environment.systemPackages = with pkgs; [
    # tmux and friendos
    byobu
    tmux
    htop
    btop

    # git tools
    gitFull

    # misc tools and utils
    curl
    wget
    nano
    neovim
    fastfetch
    jq
    rclone
    ntfsprogs

    # shell prompt customizations
    starship
    oh-my-posh # as backup lol
  ];

  # home-manager stuff
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # nix-ld flake opts
  programs.nix-ld.dev = {
    enable = true;
  };
}
