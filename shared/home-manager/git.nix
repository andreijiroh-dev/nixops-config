{ pkgs, ... }:

# Reference: https://mynixos.com/home-manager/options/programs.git and
# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
# (look for programs.git prefix)
{
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
      co = "checkout";
      switch-remote = "branch -u";
      set-push-url = "remote set-url --push";
      set-push-remote = "remote set-url --push";
      set-remote-url = "remote set-url";
      set-remote = "remote set-url";
      hard = "reset --hard";
      soft = "reset --soft";
    };
    extraConfig = {
      format = {
        signOff = true;
      };
      init = {
        defaultBranch = "main";
      };

      # see https://groups.google.com/g/binary-transparency/c/f-BI4o8HZW0/m/MDmnWideAgAJ for
      # context behind these, may cause bugs per https://bugs.debian.org/743227 and
      # https://bugs.debian.org/813157 on cloning linux-hardware sources.
      transfer = {
        fsckobjects = true; # technically we only need this, but we also enable them on fetch and receive too
      };
      fetch = {
        fsckobjects = true;
      };
      receive = {
        fsckobjects = true;
      };

      # setup remotes automatically as we push instead of doing that first manually
      push = {
        autoSetupRemote = true;
      };
    };
  };
}