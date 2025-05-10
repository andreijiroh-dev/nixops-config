# This is the meta configuration for my dotfiles with home-manager, except
# some home.{username,userDirectory} configs to ensure portability between
# hosts

{ config, pkgs, lib, home-manager, ... }:

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
  home.stateVersion = "24.11"; # Please read the comment before changing.

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
    enableExtensionUpdateCheck = true;
    mutableExtensionsDir = true;
    # userSettings = {
    #   "nix.enableLanguageServer" = true;
    #   "nix.serverPath" = "nil";
    #   "window.customTitleBarVisibility" = "auto";
    #   "window.titleBarStyle" = "custom";
    #   "window.menuBarVisibility" = "classic";
    #   "redhat.telemetry.enabled" = true;
    #   "github.copilot.editor.enableAutoCompletions" = false;
    #   "github.copilot.chat.followUps" = "always";
    #   "github.copilot.chat.terminalChatLocation" = "terminal";
    #   "git.confirmSync" = false;
    #   "microsoft-authentication.implementation" = "msal";
    #   "workbench.colorTheme" = "GitHub Dark Colorblind (Beta)";
    #   "workbench.iconTheme" = "material-icon-theme";
    #   "workbench.productIconTheme" = "material-product-icons";
    # };
    # We're importing what's generated from nix4vscode here as a workaround
    # for now.
    #extensions = lib.attrsets.mapAttrsToList (_: v: v) vscExts;
  };
}
