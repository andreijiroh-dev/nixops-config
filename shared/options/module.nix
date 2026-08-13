{
  lib,
  config,
  options,
  pkgs,
  ...
}:

{
  imports = [
    ./agenix.nix
    ./gnupg.nix
  ];
}
