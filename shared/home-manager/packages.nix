{ pkgs, ... }:

{
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
    rpi-imager

    ## devtools ##
    # https://devenv.sh
    devenv
    # needed for devenv
    direnv
    # https://cli.github.com
    gh
    glab
    fjo
    # bet we'll going to have a field day since Copilot is now available for free
    # (this is seperate from the gh copilot extension for those asking)
    # context: https://github.blog/news-insights/product-news/github-copilot-in-vscode-free/
    gh-copilot
    # markdownlint
    markdownlint-cli
    # https://doppler.com
    doppler
    # https://developers.1password.com
    _1password-cli
    keychain # https://funtoo.org
    gnupg
    gpg-tui
    # imported from my nix profile list to avoid conflicts #
    gpgme
    jq
    # workaround: https://discourse.nixos.org/t/need-help-with-resolving-missing-dependencies-for-auto-patchelf-on-termius/69722/2?u=ajhalili2006
    (pkgs.termius.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.sqlite ];
    }))
    zed-editor

    ## programming languages
    # js
    deno
    nodejs_22
    # python
    python313
    pipx
    pipenv
    # go + rust
    go
    rustup

    # linters and formatters
    shellcheck
    hadolint
    shfmt

    ## language servers ##
    # nix language server - https://github.com/oxalica/nil
    nil
    nixd
    # https://github.com/alesbrelih/gitlab-ci-ls
    #gitlab-ci-ls

    ## misc system utils and friends
    # https://httpie.io
    httpie
    byobu
    tmux
    openssl
    unrar-wrapper
    storj-uplink
    rclone

    # shell utils
    starship
    oh-my-posh
    blesh

    # archival tools
    yt-dlp
    twitch-dl
    twitch-chat-downloader
  ];

  programs.bashmount = {
    enable = true;
  };

  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      batgrep
      batwatch
    ];
  };
}
