{ pkgs, ... }:

{
  # enable gpg-agent with SSH support
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     enableBrowserSocket = true;
     pinentryPackage = pkgs.pinentry-curses;
  };

  environment.systemPackages = with pkgs; [
    gnupg
    gpgme
    gpgme.dev
    pinentry-tty
    pinentry-curses
  ];
}