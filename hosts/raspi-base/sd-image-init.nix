{ config, pkgs, ... }:

{
  # Adapted from https://github.com/NixOS/nixpkgs/blob/e89ecac0a26cdf4546298c565e880f00d4ab8649/nixos/modules/virtualisation/amazon-init.nix
  systemd.services.sd-image-init = {
    description = "Reconfigure the system from SD image userdata on startup";

    wantedBy = [ "multi-user.target" ];
    after = [ "multi-user.target" ];
    requires = [ "network-online.target" ];

    restartIfChanged = false;
    unitConfig.X-StopOnRemoval = false;

    script = ''
      #!${pkgs.runtimeShell} -eu

      echo "attempting to fetch configuration from SD image user data..."

      export HOME=/root
      export PATH=${pkgs.lib.makeBinPath [ config.nix.package pkgs.systemd pkgs.gnugrep pkgs.git pkgs.gnutar pkgs.gzip pkgs.gnused config.system.build.nixos-rebuild config.system.build.nixos-generate-config]}:$PATH
      export NIX_PATH=nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos:nixos-config=/etc/nixos/configuration.nix:/nix/var/nix/profiles/per-user/root/channels

      userData=/etc/sd-image-metadata/configuration.nix
      userDataExtra=/etc/sd-image-metadata/sd-image-init.nix

      if [ -s "$userData" ]; then
        # If the user-data looks like it could be a nix expression,
        # copy it over. Also, look for a magic three-hash comment and set
        # that as the channel.
        if sed '/^\(#\|SSH_HOST_.*\)/d' < "$userData" | grep -q '\S'; then
          channels="$(grep '^###' "$userData" | sed 's|###\s*||')"
          while IFS= read -r channel; do
            echo "writing channel: $channel"
          done < <(printf "%s\n" "$channels")

          if [[ -n "$channels" ]]; then
            printf "%s" "$channels" > /root/.nix-channels
            nix-channel --update
          fi

          echo "generating hardware configuration"
          nixos-generate-config
          echo "setting configuration from SD image user data"
          cp "$userData" "$userDataExtra" /etc/nixos/
        else
          echo "user data does not appear to be a Nix expression; ignoring"
          exit
        fi
      else
        echo "no user data is available"
        exit
      fi

      nixos-rebuild switch
    '';

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}