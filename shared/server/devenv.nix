{ pkgs, ... }:

{
  environment.defaultPackages = with pkgs; [
    direnv
    cachix
    devbox
  ];

  virtualisation = {
    podman = {
      enable = true;
      extraPackages = with pkgs; [
        gvisor
      ];
    };
    docker = {
      enable = true;
      enableOnBoot = true;
      daemon = {
        settings = {
          dns = [
            "1.1.1.1"
            "1.0.0.1"
          ];
          #ipv6 = true;
        };
      };
    };
    libvirtd = {
      enable = true;
    };
  };

  programs.virt-manager.enable = true;
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  boot.binfmt = {
    preferStaticEmulators = true;
    addEmulatedSystemsToNixSandbox = true;
  };
}