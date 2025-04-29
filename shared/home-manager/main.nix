# This is the meta configuration for my dotfiles with home-manager, except
# some home.{username,userDirectory} configs to ensure portability between
# hosts

{ config, pkgs, lib, home-manager, ... }:

{
  imports = [
    ./packages.nix
    ./git.nix
    ./shell.nix
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    #".local/lib/bash/ssh-agent-loader".source = ../../misc/bash/lib/ssh-agent-loader;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gildedguy/etc/profile.d/hm-session-vars.sh
  #

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
