{ lib, config, options, pkgs, ... }:

{
  options.nixops-config.secretOps.gnupg = {
    enable = lib.mkEnableOption "Enable GnuPG with gpg-agent";
    pinentryPkg = lib.mkOption {
      type = lib.types.package;
      default = pkgs.pinentry-curses;
      description = ''
        The pinentry package to use for password prompts. 
        Defaults to curses for terminal-based password entry.
      '';
    };
    sshAgentIntegration = lib.mkEnableOption "When set to true, ";
  };
}