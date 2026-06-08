{
  pkgs,
  zen-browser,
  config,
  lib,
  ...
}:

{
  config = {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox;
    };

    environment.systemPackages = [
      zen-browser.packages.${pkgs.system}.default
    ];
  };
}
