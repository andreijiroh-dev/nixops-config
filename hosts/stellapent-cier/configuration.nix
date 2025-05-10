# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ../../shared/desktop/bluetooth.nix
      ../../shared/desktop/firewall.nix
      ../../shared/desktop/kde-plasma.nix
      ../../shared/flatpak.nix
      ../../shared/gnupg.nix
      ../../shared/locale.nix
      ../../shared/meta-configs.nix
      ../../shared/networking.nix
      ../../shared/server/ssh.nix
      ../../shared/server/tailscale.nix
      ../../shared/systemd.nix
      ../../shared/yubikey.nix
      ../../shared/server/devenv.nix
      ../../shared/1password.nix
      ../../shared/desktop/firefox.nix
      ../../shared/shells/bash.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # for raspi builds I guess

  networking = {
    hostName = "stellapent-cier";
    hosts = with import ../../shared/networking/hosts-file.nix; hosts.stellapent-cier;
    networkmanager = {
      enable = true;
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  #hardware.pulseaudio = {
  #  enable = true;
  #  package = pkgs.pulseaudioFull;
  #};
  #hardware.pulseaudio.extraConfig = "
  #  load-module module-switch-on-connect
  #";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # home-manager specifics
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Might be obvious to some since I'm technically roleplaying on my
  # old HP laptop my overseas Filipino dad gave me in 2024.
  users.users.gildedguy = {
    isNormalUser = true;
    description = "Gildedguy (Michael Moy)"; # We're not impersonating the animatior here.
    extraGroups = [ "networkmanager" "wheel" "docker"];
    openssh = {
      authorizedKeys.keys = with import ../../shared/ssh-keys.nix; [
        personal.y2022
        personal.passwordless
        work.recaptime-dev.crew
        rp.gildedguy
      ];
    };
    #home-manager = {
    #  enable = true;
    #};
  };
  home-manager.users.gildedguy = import ./users/gildedguy.nix;
  #programs.home-manager.enable = true; # allow home-manager to manage itself

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    dig
    btop
    htop
    icu
    thunderbird
    google-chrome
    microsoft-edge
    kdePackages.kate
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_US
    gnupg
    gpg-tui
    gpgme
    byobu
    tmux
    android-tools
    adbtuifm
  ];

  # logind adjustments for this laptop to run as a headless server while
  # the lid is closed.
  services.logind = {
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
    lidSwitch = "ignore";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
