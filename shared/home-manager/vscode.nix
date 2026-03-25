{
  pkgs,
  config,
  lib,
  self,
  ...
}@args:

let
  extensions = with import ../vscode/extensions.nix args; extIndex;
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
