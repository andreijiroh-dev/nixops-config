{ pkgs, lib, ... }: {
  # Allow local config imports
  imports = lib.optionals (builtins.pathExists ./dev.local.nix) [
    ./dev.local.nix
  ];

  # Stick with unstable channel as usual
  channel = "unstable";

  packages = with pkgs; [
    # git tools
    gitFull
    github-cli
    glab

    # shell + Containerfile linting/formatting
    shellcheck
    shfmt
    hadolint

    # nix utils
    nixos-generators
    nil
    nixfmt
    ragenix

    # genai toolkit
    gemini-cli
    github-copilot-cli

    # misc
    rage
    openssh
    cloudflared
  ];

  idx = {
    extensions = [
      "jnoortheen.nix-ide"
      "mads-hartmann.bash-ide-vscode"
      "bbenoist.nix"
      "tamasfe.even-better-toml"
      "timonwong.shellcheck"
      "google.gemini-cli-vscode-ide-companion"
    ];
    workspace = {
      onCreate.default.openFiles = [ "flake.nix" ];
    };
  };

  env = {
    DOCKER_BUILDKIT = "1";
  };

  services.docker.enable = true;
}