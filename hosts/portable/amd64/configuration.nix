# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, home-manager, ... }:

let
  baseHmConfig = import ../../../shared/home-manager/main.nix {
    inherit config pkgs lib home-manager;
  };

    # localhost + local network in HaliliFam WiFi network
  baseHostsFile = with import ../../shared/hosts-file.nix; {
    "127.0.0.1" = localhost ++ [
      "nixos-portable.local"
      "nixos-portable.tailnet"
      "nixos-portable.fawn-cod.ts.net"
    ];
  } // localNetwork.halilifam;

  # tailnet, blocking ads via blackholing to 0.0.0.0, etc.
  extraHosts = with import ../../shared/hosts-file.nix;
    tailnet;

  # them merge them all together
  hostsFile = baseHostsFile // extraHosts;
in
{
  imports =
    [
      ../../../shared/meta.nix
      ../../../shared/desktop/base.nix
      ../../../shared/desktop/kde-plasma.nix
      ../../../shared/server/ssh.nix
      ../../../shared/server/tailscale.nix
      ../../../shared/server/devenv.nix
      #../../../shared/server/cockpit.nix
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos-portable"; # Define your hostname.
    hosts = hostsFile;
    networkmanager.enable = true; # manage networking via networkmanager
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
    #enable = true;
    useGlobalPkgs = true;
    users.ajhalili2006 = baseHmConfig // {
      home.username = "ajhalili2006";
      home.homeDirectory = "/home/ajhalili2006";
      home.stateVersion = "25.05";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ajhalili2006 = {
    isNormalUser = true;
    description = "Andrei Jiroh Halili";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.nixos.tags = [ "portable-configs" "portable-amd64" ];
}
