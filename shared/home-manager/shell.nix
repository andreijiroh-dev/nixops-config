{ lib, pkgs, dev-pkgs, ... }: {
  home.packages = [
    pkgs.detect-vscode-for-git
    pkgs.ssh-agent-loader
  ];

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
    ll = "ls -l";
    la = "ls -A";
    l = "ls -CF";
  };

  home.sessionVariables = {
    NIXOS_ALLOW_UNFREE = "1"; # for impure builds
    # use nano for now
    EDITOR = "nano";
    GIT_EDITOR = "nano";
    VISUAL = "nano";
    # enable buildkit on `docker build` by default
    DOCKER_BUILDKIT = "1";
    # Context: https://drewdevault.com/2021/08/06/goproxy-breaks-go.html
    GOPROXY = "direct";
    GOSUMDB = "off";
    # set GOPATH to ~/.local/share/go
    GOPATH = "$HOME/.local/share/go";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoredups"
      "ignorespace"
    ];
    enableVteIntegration = true;
    profileExtra = ''
      # HACK: using nix outside of nixos
      if [[ -f /etc/profile.d/nix.sh ]]; then
        . /etc/profile.d/nix.sh
      fi
      #export PATH=/nix/var/nix/profiles/default/bin:$HOME/.nix-profile/bin:$HOME/bin:$PATH

      # set PATH so it includes user's private bin if it exists
      if [ -d "$HOME/bin" ] ; then
          PATH="$HOME/bin:$PATH"
      fi
      if [ -d "$HOME/.local/bin" ] ; then
          PATH="$HOME/.local/bin:$PATH"
      fi

      # source our ssh-agent-loader first
      FF_SKIP_AUTO_SSH_AGENT_LOADER=true . ${pkgs.ssh-agent-loader}/bin/ssh-agent-loader

      # try to use keychain in this situation
      SSH_AGENT_LOADER_SLIENT=1 ssh-agent-loader keychain

      if [ -n $BASH_VERSION ]; then
        . $HOME/.bashrc
      fi

      unset SSH_AGENT_LOADED
    '';
    bashrcExtra = ''
      # detect if we are inside VS Code
      source ${pkgs.detect-vscode-for-git}/bin/detect-vscode-for-git

      # HACK: https://github.com/akinomyoga/ble.sh/wiki/Manual-A1-Installation#user-content-nixpkgs
      export BLESH_PATH=$(blesh-share)
      [[ $- == *i* ]] && source "$BLESH_PATH/ble.sh" --attach=none
    '';
    initExtra = ''
      # hackaround for GPG on CLI mode
      export GPG_TTY=$(tty)
      
      # source our ssh-agent-loader first
      source ${pkgs.ssh-agent-loader}/bin/ssh-agent-loader

      # hack around for 1Password CLI when 1Password desktop app is up
      if [[ $$FF_USE_OP_CLI_PLUGINS == "true" ]]; then
        test -f "$HOME/.config/op/plugins.sh" && source "$HOME/.config/op/plugins.sh"
      fi

      # hook in direnv and friends
      eval "$(direnv hook bash)"

      if [ "$(command -v dircolors)" != "" ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
      fi

      export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

      [[ ! ''${BLE_VERSION-} ]] || ble-attach
    '';
    #enableLsColors = true;
  };

  programs.zsh = {
    enable = true;
  };

  programs = {
    starship = {
      enable = true;
      settings = lib.importTOML ../../misc/starship.toml;
    };
    direnv = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };
  };
}
