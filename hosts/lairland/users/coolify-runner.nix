{ config, pkgs, lib, zen-browser, dev-pkgs, ... }:

{
  users.users.coolify-runner = {
    isSystemUser = true;
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
}