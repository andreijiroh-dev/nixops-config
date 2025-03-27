{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/cd-dvd/sd-image-aarch64.nix>
    ./sd-image-init.nix
  ];

  # bzip2 compression takes loads of time with emulation, skip it. Enable
  # this if you're low on space.
  sdImage.compressImage = false;

  sdImage.populateRootCommands = ''
    mkdir -p ./files/etc/sd-image-metadata/
    cp ./configuration.nix ./files/etc/sd-image-metadata/configuration.nix
    cp ./sd-image-init.nix ./files/etc/sd-image-metadata/sd-image-init.nix
  '';

  # OpenSSH is forced to have an empty `wantedBy` on the installer system[1], this won't allow it
  # to be automatically started. Override it with the normal value.
  # [1] https://github.com/NixOS/nixpkgs/blob/9e5aa25/nixos/modules/profiles/installation-device.nix#L76
  systemd.services.sshd.wantedBy = lib.mkOverride 40 [ "multi-user.target" ];

  # Enable OpenSSH out of the box.
  services.sshd.enable = true;

  # The installer starts with a "nixos" user to allow installation, so add the SSH key to
  # that user. Note that the key is, at the time of writing, put in `/etc/ssh/authorized_keys.d`
  users.extraUsers.nixos.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev"
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh"
  ];

  # Use a default root SSH login.
  # services.openssh.permitRootLogin = "yes";
  users.users.root.password = "nixos-emergency-meeting";
  users.users.root.openssh = {
    authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh"
    ];
  };

  # Wireless networking (1). You might want to enable this if your Pi is not attached via Ethernet.
  # I know I have to setup a temporary hidden SSID with a random password for automation purposes,
  # so dont't rely on values here.
  networking.wireless = {
    enable = true;
    interfaces = [ "wlan0" ];
    networks = {
      "UnattendedNixosSetup_2.4G" = {
        psk = "82a240704f00a476a28dc53b";
        hidden = true;
      };
      "UnattendedNixosSetup_5G" = {
        psk = "82a240704f00a476a28dc53b";
        hidden = true;
      };
    };
    allowAuxiliaryImperativeNetworks = true;
  };

  # Wireless networking (2). Enables `wpa_supplicant` on boot.
  systemd.services.wpa_supplicant.wantedBy = lib.mkOverride 10 [ "default.target" ];

  # NTP time sync.
  services.timesyncd.enable = true;
}