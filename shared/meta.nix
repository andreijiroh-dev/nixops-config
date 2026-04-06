# One Nix file to import all the base configs without cluttering the per-host
# imports, alongside a minimal base packages and some tweaks at sysctls.
{
  pkgs,
  config,
  ...
}:

{
  # import configs first
  imports = [
    ./options.nix
    # import shared configs
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
    ./server/ssh.nix
    ./server/tailscale.nix
    ./agenix.nix
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
    fastfetch
    jq
    rclone
    ntfsprogs

    # TUI-based text editors
    nano
    neovim
    emacs

    # shell prompt customizations
    starship
    oh-my-posh # as backup lol

    # iykyk secretops (see also agenix.nix)
    age
    rage
  ];

  # home-manager stuff
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # nix-ld flake opts
  programs.nix-ld.dev = {
    enable = true;
  };

  # sysctl stuff
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
    "vm.swappiness" = 60;
  };
}
