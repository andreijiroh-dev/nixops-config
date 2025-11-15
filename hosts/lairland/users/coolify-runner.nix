{ config, pkgs, lib, zen-browser, dev-pkgs, ... }:

{
  users.users.coolify-runner = {
    isNormalUser = true;
    uid = 9999;
    group = "coolify-runner";
    description = "Coolify service user";
    home = "/opt/docker-data/coolify";
    extraGroups = [ "docker" ];
    linger = false;
    openssh.authorizedKeys.keys = with import ../../../shared/ssh-keys.nix; [
      personal.campus-comlab
      infra.termius
    ];
    createHome = true;
  };
  users.groups.coolify-runner = {
    gid = 9999;
  };

  # Force chown on home directory to fix permissions after UID/GID change
  system.activationScripts.chownCoolifyRunnerHome = {
    text = ''
      chown -R coolify-runner:coolify-runner ${config.users.users.coolify-runner.home}
    '';
    deps = [ "users" ];
  };
}