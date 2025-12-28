{ config, lib, pkgs, ... }:

# Reference: https://mynixos.com/home-manager/options/programs.git and
# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.git.enable
# (look for programs.git prefix)
{
   programs.git = {
    enable = true;
    package = pkgs.gitFull;
    lfs = {
      enable = true;
    };
    maintenance = {
      enable = true;
    };
    ignores = [
      "*~"
      "*.swp"
      "*.tmp"
      "*.save"
      ".DS_Store"
      ".cache"
      "public/"
      "node_modules/"
      "data/"
      ".data/"
      "tmp/"
      "*.decrypted"
    ];
    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 @ajhalili2006's SSH key, circa 2022";
      signByDefault = true;
      format = "ssh";
      signer = lib.mkIf (
        (config.services.desktopManager.plasma6.enable or false) ||
        (config.services.xserver.desktopManager.plasma5.enable or false)
      ) "${pkgs._1password-gui}/share/1password/op-ssh-sign";
    };
    settings = {
      user = {
        name = "Andrei Jiroh Halili";
        email = "ajhalili2006@andreijiroh.dev";
      };

      alias = {
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

      format = {
        signOff = true;
      };
      init = {
        defaultBranch = "main";
      };

      # credential helpers
      credential = {
        "https://github.com".helper = "!gh auth git-credential";
        "https://gist.github.com".helper = "!gh auth git-credential";
        "https://gitlab.com".helper = "!glab auth git-credential";
        "https://mau.dev".helper = "!glab auth git-credential";
        "https://gitlab.alpinelinux.org".helper = "!glab auth git-credential";
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
