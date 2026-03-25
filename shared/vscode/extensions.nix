{
  pkgs,
  config,
  lib,
  self,
  ...
}:

let
  inherit (pkgs.nix4vscode)
    forVscode
    forVscodePrerelease
    ;
  inherit (pkgs.vscode-utils)
    extensionFromVscodeMarketplace
    ;
in
{
  extIndex =
    forVscode [
      # themeing
      "GitHub.github-vscode-theme"
      "PKief.material-icon-theme"
      "PKief.material-product-icons"
      "SpaceBox.monospace-idx-theme"

      # tooling
      "mkhl.direnv"
      "github.vscode-github-actions"
      "ms-vscode-remote.remote-ssh-edit"
      "ms-azuretools.vscode-containers"
      "GitHub.copilot-chat"
      "wdhongtw.gpg-indicator"
      "WakaTime.vscode-wakatime.29.0.3"
      "ms-vscode.remote-repositories"
      "GitHub.remotehub"

      # languages: formatting, code highlighting, etc.
      "bbenoist.Nix"
      "arrterian.nix-env-selector"
      "brettm12345.nixfmt-vscode"
      #"jnoortheen.nix-ide"
      "tamasfe.even-better-toml"
      "bierner.emojisense"
      "redhat.vscode-yaml"
      "mads-hartmann.bash-ide-vscode"
      "yzhang.markdown-all-in-one"
      "bierner.markdown-checkbox"
      "bierner.markdown-emoji"
      "bierner.markdown-footnotes"
      "yahyabatulu.vscode-markdown-alert"
      "bierner.markdown-preview-github-styles"
      "bierner.markdown-mermaid"
      "bierner.markdown-yaml-preamble"
      "DavidAnson.vscode-markdownlint"
      "timonwong.shellcheck"
      "exiasr.hadolint"
    ]
    ++ forVscodePrerelease [
      # tooling
      "ms-vscode.remote-server"
      "ms-vscode-remote.remote-ssh"
      "GitHub.vscode-pull-request-github"
      "eamodio.gitlens"
    ];
}
