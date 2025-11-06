# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  self,
  config,
  pkgs,
  lib,
  ...
}:
let
  # localhost + local network in HaliliFam WiFi network
  baseHostsFile =
    with import ../../shared/hosts-file.nix;
    {
      "127.0.0.1" = localhost ++ [
        "lairland.local"
        "lairland.tailnet"
        "lairland.fawn-cod.ts.net"
      ];
    }
    // localNetwork.halilifam;

  # tailnet, blocking ads via blackholing to 0.0.0.0, etc.
  extraHosts = with import ../../shared/hosts-file.nix; tailnet;

  # them merge them all together
  hostsFile = baseHostsFile // extraHosts;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../shared/meta.nix
      ../../shared/desktop/base.nix
      ../../shared/desktop/kde-plasma.nix
      ../../shared/server/ssh.nix
      ../../shared/server/tailscale.nix
      ../../shared/server/devenv.nix
      ../../shared/server/cockpit.nix
      ./users/ajhalili2006.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking = {
    hosts = hostsFile;
    hostName = "lairland";
    networkmanager.enable = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
  services.pulseaudio.enable = false;
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ajhalili2006 = {
    isNormalUser = true;
    description = "Andrei Jiroh Halili";
    extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
    ];
    openssh.authorizedKeys.keys = with import ../../shared/ssh-keys.nix; [
        personal.y2022
        personal.passwordless
        work.recaptime-dev.crew
        rp.gildedguy
      ];
    linger = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;
}
