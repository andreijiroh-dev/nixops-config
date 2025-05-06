{ ... }: {
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

  home.sessionVariables = {
    NIXOS_ALLOW_UNFREE = "1"; # for impure builds
    # use nano for now
    EDITOR = "nano";
    GIT_EDITOR = "nano";
    VISUAL = "nano";
    # enable buildkit on `docker build` by default
    DOCKER_BUILDKIT = "1";
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
      # source our ssh-agent-loader first
      FF_SKIP_AUTO_SSH_AGENT_LOADER=true source ${../../misc/bash/lib/ssh-agent-loader}

      # try to use keychain in this situation
      ssh-agent-loader keychain
    '';
    bashrcExtra = ''
      # detect if we are inside VS Code
      source ${../../misc/bash/lib/detect-vscode-for-git}
    '';
    initExtra = ''
      # source our ssh-agent-loader first
      unset SSH_AGENT_LOADED
      source ${../../misc/bash/lib/ssh-agent-loader}

      # hack around for 1Password CLI when 1Password desktop app is up
      if [[ $$FF_USE_OP_CLI_PLUGINS == "true" ]]; then
        test -f "$HOME/.config/op/plugins.sh" && source "$HOME/.config/op/plugins.sh"
      fi

      # hook in direnv and friends
      eval "$(direnv hook bash)"
    '';
    #enableLsColors = true;
  };

  programs.zsh = {
    enable = true;
  };
}