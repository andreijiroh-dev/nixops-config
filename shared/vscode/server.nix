{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ../options.nix
  ];
  config = {
    services.vscode-server = {
      enable = true;
      installPath = [
        "$HOME/.vscode-server"
        "$HOME/.vscode-server-oss"
        "$HOME/.vscode-server-insiders"
      ];
    };
  };
}
