{
  config,
  lib,
  pkgs,
  self,
  ...
}@args:

let
  extensions = with import ../vscode/extensions.nix args; extIndex;
in
{
  imports = [
    ./server.nix
    "${self}/shared/options.nix"
  ];

  config = {
    programs.vscode = {
      package = pkgs.vscode;
      enable = true;
      extensions = extensions;
    };
  };
}
