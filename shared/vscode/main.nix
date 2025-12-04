{ config, lib, pkgs, ... }:

let
  inherit (pkgs.nix4vscode)
    forVscode
    forVscodePrerelease
  ;
in
{
  imports = [
    ./server.nix
  ];
  
  programs.vscode = {
    package = pkgs.vscode;
    enable = true;
    extensions =
      forVscode [
        # themeing
        "GitHub.github-vscode-theme"
        "PKief.material-icon-theme"
        "PKief.material-product-icons"

        # tooling
        "mkhl.direnv"
        "github.vscode-github-actions"
        "ms-vscode-remote.remote-ssh-edit"
        "ms-azuretools.vscode-containers"
        "GitHub.copilot-chat"
        "wdhongtw.gpg-indicator"
        "WakaTime.vscode-wakatime"
        "ms-vscode.remote-repositories"
        "GitHub.remotehub"

        # languages: formatting, code highlighting, etc.
        "bbenoist.Nix"
        "arrterian.nix-env-selector"
        "brettm12345.nixfmt-vscode"
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

      ] ++ forVscodePrerelease [
        # tooling
        "eamodio.gitlens"
        "ms-vscode.remote-server"
        "ms-vscode-remote.remote-ssh"
        "GitHub.vscode-pull-request-github"
      ] ++ [
        # AI tools
        # Manually pinned to fix hash mismatch (since Copilot releases are tied to VSC monthly releases
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          name = "copilot";
          publisher = "GitHub";
          version = "1.388.0";
          sha256 = "sha256-8fv+z+ksWYWDty1JPg6Pe5De1FdFLKmVC+hy8kF0s3g=";
        })
];
  };
}
