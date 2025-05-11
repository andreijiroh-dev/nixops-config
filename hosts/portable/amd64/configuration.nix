# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, ... }:

let
  baseHmConfig = import ../../../shared/home-manager/main.nix {
    inherit config pkgs lib home-manager;
  };
in
{
  imports =
    [ # Include the results of the hardware scan.
      #../../../shared/desktop/bluetooth.nix
      ../../../shared/desktop/firewall.nix
      ../../../shared/desktop/kde-plasma.nix
      ../../../shared/flatpak.nix
      ../../../shared/gnupg.nix
      ../../../shared/locale.nix
      ../../../shared/meta-configs.nix
      ../../../shared/networking.nix
      #../../../shared/server/ssh.nix
      ../../../shared/server/tailscale.nix
      ../../../shared/systemd.nix
      ../../../shared/yubikey.nix
      ../../../shared/server/devenv.nix
      ../../../shared/1password.nix
      ../../../shared/desktop/firefox.nix
      ../../../shared/shells/bash.nix
      ../../../shared/server/cockpit.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-portable"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_PH.UTF-8";
    LC_IDENTIFICATION = "en_PH.UTF-8";
    LC_MEASUREMENT = "en_PH.UTF-8";
    LC_MONETARY = "en_PH.UTF-8";
    LC_NAME = "en_PH.UTF-8";
    LC_NUMERIC = "en_PH.UTF-8";
    LC_PAPER = "en_PH.UTF-8";
    LC_TELEPHONE = "en_PH.UTF-8";
    LC_TIME = "en_PH.UTF-8";
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
  hardware.pulseaudio.enable = false;
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

  # prep for home-manager
  home-manager = {
    enable = true;
    useGlobalPkgs = true;
    users.ajhalili2006 = baseHmConfig // {
      home.username = "ajhalili2006";
      home.homeDirectory = "/home/ajhalili2006";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ajhalili2006 = {
    isNormalUser = true;
    description = "Andrei Jiroh Halili";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
