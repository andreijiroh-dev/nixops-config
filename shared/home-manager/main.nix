# This is the meta configuration for my dotfiles with home-manager, except
# some home.{username,userDirectory} configs to ensure portability between
# hosts

{ config, pkgs, lib, ... }:

{
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    ## desktop apps ##
    _1password-gui
    firefoxpwa

    ## devtools ##
    # https://httpie.io
    httpie
    # https://devenv.sh
    devenv
    # https://cli.github.com
    gh
    glab
    gitlab-ci-ls
    fjo
    # bet we'll going to have a field day since Copilot is now available for free
    # (this is seperate from the gh copilot extension for those asking)
    # context: https://github.blog/news-insights/product-news/github-copilot-in-vscode-free/
    github-copilot-cli
    # markdownlint
    markdownlint-cli
    # https://doppler.com
    doppler
    direnv
    shellcheck # https://funtoo.org
    hadolint
    _1password
    keychain

    ## programming languages
    deno
    nodejs_22
    python313
    pipx
    pipenv

    ## language servers ##
    # nix language server - https://github.com/oxalica/nil
    nil
    # https://github.com/alesbrelih/gitlab-ci-ls
    gitlab-ci-ls
  ];

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
  home.sessionVariables = {
    EDITOR = "nano";
    NIXOS_ALLOW_UNFREE = "1"; # for impure builds
    GIT_EDITOR = "code --wait";
    VISUAL = "code --wait";
    DOCKER_BUILDKIT = "1";
  };

  # taken from https://github.com/andreijiroh-dev/dotfiles/blob/main/.config/aliases
  home.shellAliases = {
    signoff = "git commit --signoff";
    status = "git status";
    stats = "git status";
    clone = "git clone";
    stage = "git add";
    unstage = "git restore --staged";
    nuke-from-index = "git rm";
    rename-branch = "git branch -m";
    set-upstream = "git branch -u";
    stash = "git stash push --keep-index";
    apply-stash = "git stash apply";
    pop-stash = "git stash pop";
    drop-stash = "git stash drop";
    yeet-stash = "git stash drop";
    push = "git push";
    fetch = "git fetch";
    submodules = "git submdoule";
    submodule = "git submodule";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # let me cook with the configs, starting with git
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    lfs = {
      enable = true;
    };
    userName = "Andrei Jiroh Halili";
    userEmail = "ajhalili2006@andreijiroh.dev";
    signing = {
      key = "4D5E631758CB9CC45941B1CE67BFC91B3DA12BE8";
      signByDefault = true;
    };
    aliases = {
      signoff = "commit --signoff";
      amend = "commit -a --amend";
      remotes = "remote -v";
      root = "rev-parse --show-toplevel";
      unstage = "restore --staged";
      stats = "status";
    };
    extraConfig = {
      format = {
        signOff = true;
      };
      init = {
        defaultBranch = "main";
      };

      # https://groups.google.com/g/binary-transparency/c/f-BI4o8HZW0
      transfer = {
        fsckobjects = true;
      };
      fetch = {
        fsckobjects = true;
      };
      receive = {
        fsckobjects = true;
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };

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
