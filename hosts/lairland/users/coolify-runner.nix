{ config, pkgs, lib, zen-browser, dev-pkgs, ... }:

{
  users.users.coolify-runner = {
    isNormalUser = true;
    uid = 9999;
    group = "coolify-runner";
    description = "Coolify service user";
    home = "/opt/docker-data/coolify";
    extraGroups = [ "docker" ];
    linger = true;
    openssh.authorizedKeys.keys = with import ../../../shared/ssh-keys.nix; [
      personal.campus-comlab
      infra.termius
    ];
    createHome = true;
  };
  users.groups.coolify-runner = {
    gid = 9999;
  };
}