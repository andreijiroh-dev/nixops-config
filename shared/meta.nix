# One Nix file to import all the base configs without cluttering the per-host
# imports, alongside a minimal base packages.
{ pkgs, ... }:

{
  # import configs first
  imports = [
    ./meta-configs.nix
    ./flatpak.nix
    ./gnupg.nix
    ./locale.nix
    ./networking.nix
    ./systemd.nix
    ./shells/bash.nix
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

    # shell prompt customizations
    starship
    oh-my-posh # as backup lol
  ];
}