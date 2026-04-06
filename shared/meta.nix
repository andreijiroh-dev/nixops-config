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
    # module opts
    ./options.nix
    # nix stuff and systemd
    ./nix.nix
    ./locale.nix
    ./networking.nix
    ./systemd.nix
    ./agenix.nix
    # shells and dev tools
    ./gnupg.nix
    ./shells/bash.nix
    ./shells/custom-prompts.nix
    ./vscode/main.nix
    ./server/ssh.nix
    ./server/tailscale.nix
    # desktop stuff
    ./1password.nix
    ./appimages.nix
  ];

  # and then the base packages itself
  config = {
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
    home.enableNixpkgsReleaseCheck = false; # ignore warnings about outdated nixpkgs in home-manager

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
  };
}
