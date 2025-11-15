# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  self,
  config,
  pkgs,
  lib,
  zen-browser,
  dev-pkgs,
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
      #../../shared/desktop/base.nix
      #../../shared/desktop/kde-plasma.nix
      ../../shared/server/ssh.nix
      ../../shared/server/tailscale.nix
      ../../shared/server/devenv.nix
      ../../shared/server/cockpit.nix
      ./users/ajhalili2006.nix
      ./users/coolify-runner.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # we're not using the TPM at the moment
  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

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

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Used by ../../bin/coolify-compose script
  environment.variables = {
    COOLIFY_DIR = "/opt/docker-data/coolify";
  };
}