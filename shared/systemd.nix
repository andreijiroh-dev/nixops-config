{ lib, config, pkgs, ... }:

{
  services.timesyncd = {
    enable = true;
    servers = [
      # https://pubfiles.pagasa.dost.gov.ph/tamss/oras/time_synchronization_for_windows_7_and_8.pdf
      "ntp.pagasa.dost.gov.ph"
      # https://www.cloudflare.com/time/
      "time.cloudflare.com"
    ];
    fallbackServers = [
      "0.asia.pool.ntp.org"
      "1.asia.pool.ntp.org"
	    "2.asia.pool.ntp.org"
	    "3.asia.pool.ntp.org"
    ];
  };

  # use systemd for boot stage 1
  boot.initrd.systemd = {
    enable = true;
    extraBin = {
      bash = lib.mkForce "${pkgs.bash}/bin/bash";
      utils = lib.mkForce "${pkgs.busybox}/bin/busybox";
      umount = lib.mkForce "${pkgs.util-linux}/bin/umount";
      nano = "${pkgs.nano}/bin/nano";
    };
  };
  boot.initrd.network.ssh.enable = true;
  boot.initrd.network.ssh.authorizedKeys = with ./ssh-keys.nix; [
    personal.y2022
    personal.passwordless
    personal.rp.gildedguy
    work.recaptime-dev.crew
    fido2Keys.hackclub_yubikey.main
    fido2Keys.hackclub_yubikey.backup
  ];
}