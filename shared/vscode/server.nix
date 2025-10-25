{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.vscode-server.enable = true;
  services.vscode-server.installPath = [
    "$HOME/.vscode-server"
    "$HOME/.vscode-server-oss"
    "$HOME/.vscode-server-insiders"
  ];
}
