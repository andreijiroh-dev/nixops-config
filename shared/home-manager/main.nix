# This is the meta configuration for my dotfiles with home-manager, except
# some home.{username,userDirectory} configs to ensure portability between
# hosts

{
  config,
  pkgs,
  lib,
  home-manager,
  ...
}:

{
  imports = [
    ./packages.nix
    ./desktop.nix
    ./git.nix
    ./shell.nix
    ./fonts.nix
  ];

  # https://fnordig.de/til/nix/home-manager-allow-unfree.html
  nixpkgs = {
    config = {
      allowUnfree = true;
      # https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.sessionPath = [
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.nix-profile/bin"
    "$HOME/.local/share/go/bin"
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles = {
      default = {
        enableExtensionUpdateCheck = true;
      };
    };
    mutableExtensionsDir = true;
  };
}
