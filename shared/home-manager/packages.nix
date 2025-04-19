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
    # needed for devenv
    direnv
    # https://developers.1password.com
    _1password-cli
    keychain # https://funtoo.org
    gnupg
    gpg-tui

    ## programming languages
    deno
    nodejs_22
    python313
    python312
    pipx
    pipenv

    # linters
    shellcheck
    hadolint

    ## language servers ##
    # nix language server - https://github.com/oxalica/nil
    nil
    # https://github.com/alesbrelih/gitlab-ci-ls
    gitlab-ci-ls

    # did we forget these?
    byobu
    tmux
  ];
}