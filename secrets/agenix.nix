# This is my agenix setup for all things SecretOps on my NixOS and home-manager
# configurations. This may be unused due to usage of agenix-rekey.
{ lib, pkgs, config, ... }:

let
  pubkeys = import ../shared/ssh-keys.nix;

  # start with the host keys
  hosts = pubkeys.hosts;

  # the you do you part
  main = pubkeys.personal.y2022;
  work = pubkeys.work.recaptime-dev.crew;
  hardwareKeys = pubkeys.fido2Keys;
in
{

}
