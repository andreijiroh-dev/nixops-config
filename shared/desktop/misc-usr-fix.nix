{ pkgs, lib, config, ... }:

let
  mountOptions = [
    "ro"                # read-only: this mount only ever needs to be read
    "resolve-symlinks"  # follow symlinks as if they were real files —
                          # some apps (OnlyOffice-style) refuse to read
                          # through symlinks under /usr/share
    "x-gvfs-hide"        # keep this mount out of file-manager sidebars
  ];
in
{
  # Purpose: NixOS has no /usr/share/fonts (fonts live in /nix/store and are
  # symlink-farmed under /run/current-system/sw/share/...), so Flatpak's
  # built-in host-font mount (/usr/share/fonts -> sandbox's /run/host/fonts)
  # finds nothing. This bind-mounts your actual font set onto the FHS path
  # non-Nix sandboxed apps expect, fixing tofu-box rendering for anything
  # that runs (even partially) inside a Flatpak sandbox.
  #
  # See also:
  # - https://wiki.nixos.org/wiki/Fixes_for_non-Nix_applications (NixOS Wiki docs re this situation)
  # - https://claude.ai/share/aefa1d19-b347-43d6-b6ad-d1a4a0e22714
  # (original chat transcript for ~ajhalili2006: https://claude.ai/chat/c29287be-3d19-452a-a2b6-15fd55de9682)
  system.fsPackages = with pkgs; [
    bindfs
  ];

  # Note that you need to set fonts.fontDir.enable to true in your NixOS config
  # for this to work (it adds the fonts to the FHS path under /run/current-system/sw/share/...). See ./fonts.nix#L8 for details.
  fileSystems."/usr/share/fonts" = {
    device = "/run/current-system/sw/share/X11/fonts";
      fsType = "fuse.bindfs";
      options = mountOptions;
  };

  # Similar with icons and themes here
  fileSystems."/usr/share/icons" = {
    device = "/run/current-system/sw/share/icons";
    fsType = "fuse.bindfs";
    options = mountOptions;
  };
  fileSystems."/usr/share/themes" = {
    device = "/run/current-system/sw/share/themes";
    fsType = "fuse.bindfs";
    options = mountOptions;
  };
}
