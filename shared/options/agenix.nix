{
  lib,
  config,
  options,
  pkgs,
  ...
}:

{
  options.nixops-config.secretOps.agenix = {
    enable = lib.mkEnableOption "Enable agenix and agenix-reky for this NixOS or home-manager config. Requires `rekey.hostPubkey` to be set.";
  };
}
