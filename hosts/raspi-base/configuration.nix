
{ config, lib, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Needed to continue SD image initialization after installer removes its own unit.
    ./sd-image-init.nix
  ];

  # Use the extlinux boot loader. (NixOS wants to enable GRUB by default)
  boot.loader.grub.enable = false;
  # Enables the generation of /boot/extlinux/extlinux.conf
  boot.loader.generic-extlinux-compatible.enable = true;

  # Enable OpenSSH out of the box.
  services.sshd.enable = true;

  # Since we are customizing things bts, we'll disabled the default nixos user.
  users.extraUsers.nixos = {
    enable = false;
  };

  users.extraUsers.ajhalili2006 = {
    description = "~ajhalili2006";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh"
    ];
  };

  # Use a default root SSH login.
  # services.openssh.permitRootLogin = "yes";
  # users.users.root.password = "nixos";
  users.users.root.openssh = {
    authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEXuD3hJwInlcHs3wkXWAWNo8es3bPAd2e8ipjyqgGp2 ajhalili2006@andreijiroh.dev"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDUnTexcVQTGT+UhX8MRPkMvM6FPuskbY2Dn0ScZ3+ot ~ajhalili2006 [passwordless key for sshfs]"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDEYDna7HlVN6FL+Mxaof+WH5EoVmaUrM7GFAdQSveTJ ajhalili2006@crew.recaptime.dev"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCzMlrUe7qMA1P0lP56lq2dKTrwFU6CrVltQ9um+PhOMLkoi31kAlujHtWF6mqGRLXcK0Ao/0Wqug++r82Zu0u7dpAv8LCExtaRRMzagwPkEe4OOqUBOpS6mggfsik8mNA+1UtpkXJ+ZiB4cXtNKEZC0jtxWOTXSV67qgkSxuO+YBWB+7pnESkB0KorqwOoWGGUVfYQtbKUAt6VqM4s6dn7saXqwmN0tCPO6a+4L4mazkYjFD11HhktYsjP9dvnxYSOtMrSFb9JOXRST2LdiIJgwg+HTqBSWGO7aBRHMJaTF3ajlbMtKDQI/EcNQLyGgX6yFdjjzz9DRY+2oU0vPTytdqM2BKsfLlR0GVg7BVL7TZPaLJ1lgpCl4Z1oClW9FOzhnYJVT0W+IKPsnYsFPfv/BVgjWF7YtLdc5zqFJ31PULtikCyd0I6Kt95YD0HdrlR2faWcBHI8KKEAwCCanodGnK/xTOxisTX2dXOxx3mvR/L3Wil2ca5hnD+vt500/o8= gildedguy@andreijiroh"
    ];
  };

  # Wireless networking (1). You might want to enable this if your Pi is not attached via Ethernet.
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

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;
  networking.interfaces.wlan0.useDHCP = true;

  # NTP time sync.
  services.timesyncd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  # NGINX sample
  networking.firewall.allowedTCPPorts = [ 
    80
  ];
}