{ pkgs, ... }:

{
  # enable gpg-agent with SSH support
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
     enableBrowserSocket = true;
  };

  environment.systemPackages = with pkgs; [
    gnupg
    gpgme
    gpgme.dev
    pinentry-tty
  ];
}