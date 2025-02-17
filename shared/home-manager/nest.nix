{ pkgs, ... }:

{
  # TBD

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    _1password-cli
    gh
    glab
  ];

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
}