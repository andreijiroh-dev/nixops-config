# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../shared/meta-configs.nix
      ../../shared/networking.nix
      ../../shared/locale.nix
      ../../shared/server/tailscale.nix
      ../../shared/server/ssh.nix
      ../../shared/desktop/kde-plasma.nix
      ../../shared/desktop/bluetooth.nix
      ../../shared/desktop/firewall.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stellapent-cier"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking via networkmanager
  networking.networkmanager.enable = true;

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

  # firmware configurations
  #hardware.firmware = with pkgs; [
  #  (pkgs.fetchurl {
  #    url = "https://raw.githubusercontent.com/winterheart/broadcom-bt-firmware/refs/heads/master/brcm/BCM43142A0-0a5c-216d.hcd";
  #    sha256 = "9ac1e0fac850eec21cda47977858039ffc774d0cfffc6688093a722efc5a3ec0";
  #  })
  #];

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Might be obvious to some since I'm technically roleplaying as 
  users.users.gildedguy = {
    isNormalUser = true;
    description = "Gildedguy (Michael Moy)";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };

  # home-manager specifics
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.gildedguy = (import ./users/gildedguy.nix);
  programs.home-manager.enable = true; # allow home-manager to manage itself

  # Install firefox.
  programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    dig
    broadcom-bt-firmware
    btop
    htop
    google-chrome
    direnv
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;

  # enable gpg-agent with SSH support
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
