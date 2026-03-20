{ lib, config, pkgs, options, ... }:

{
  imports = [
    ./options/agenix.nix
    ./options/gnupg.nix
  ];
}