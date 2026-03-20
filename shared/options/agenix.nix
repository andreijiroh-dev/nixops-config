{ lib, config, options, pkgs, ... }:

{
  imports = [
    ../options.nix
  ];
  options.nixops-config.secretOps.agenix = {
    enable = lib.mkOption {
      description = "Enable agenix and agenix-reky for this NixOS or home-manager config. Requires `rekey.hostPubkey` to be set.";
      default = false;
      type = lib.types.bool;
    };
  };
}