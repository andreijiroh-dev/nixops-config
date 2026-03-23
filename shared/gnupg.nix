{ pkgs, lib, config, ... }:

let
  cfg = config.nixops-config.secretOps.gnupg;
in
{
  config = lib.mkIf cfg.enable {
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = cfg.sshAgentIntegration;
      pinentryPackage = cfg.pinentryPkg;
    };

    environment.systemPackages = with pkgs; [
      gnupg
      gpgme
      gpgme.dev
      pinentry-tty
      cfg.pinentryPkg
    ];
  };
}