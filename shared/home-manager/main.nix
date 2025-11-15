# This is the meta configuration for my dotfiles with home-manager, except
# some home.{username,userDirectory} configs to ensure portability between
# hosts

{
  config,
  pkgs,
  lib,
  home-manager,
  zen-browser,
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
}
