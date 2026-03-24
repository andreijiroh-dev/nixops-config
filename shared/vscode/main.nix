{
  config,
  lib,
  pkgs,
  self,
  ...
}:

let
  extensions = with ../vscode/extensions.nix; extIndex;
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
