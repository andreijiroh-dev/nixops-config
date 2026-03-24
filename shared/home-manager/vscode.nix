{
  pkgs,
  config,
  lib,
  self,
  ...
}:

let
  extensions = with ../vscode/extensions.nix; extIndex;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles = {
      default = {
        enableExtensionUpdateCheck = true;
        extensions = extensions;
      };
    };
    mutableExtensionsDir = true;
  };
}
