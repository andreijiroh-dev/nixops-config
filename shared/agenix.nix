# This is my agenix setup for all things SecretOps on my NixOS and home-manager
# configurations.
{ lib, pkgs, config, self, ... }:

let
  pubkeys = import ../shared/ssh-keys.nix;

  # the you do you part
  main = pubkeys.personal.y2022;
  work = pubkeys.work.recaptime-dev.crew;
  hackclub_yk = pubkeys.fido2Keys.hackclub_yubikey;
in
{
  age.rekey = {
    # Master identity - private key used for decryption (must exist on machine running rekey)
    masterIdentities = [
      main
      work
      hackclub_yk.main
    ];

    # Store rekeyed secrets locally per-host
    storageMode = "local";
    localStorageDir = lib.mkDefault (self + "/secrets/rekeyed/${config.networking.hostName}");

    # Host pubkey must be set per-host in configurations/nixos/<host>/default.nix:
    # age.rekey.hostPubkey = "ssh-ed25519 AAAA...";
  };
}
