# Desktop apps and related configs go here in this Nix file
{ pkgs, ... }:

{
  imports = [
    # make sure to import the zen-browser home module
    # for programs.zen-browser to work
    #zen-browser.homeModules.beta
  ];

  home.packages = with pkgs; [
    _1password-gui
    firefoxpwa
    #rpi-imager
    kdePackages.krfb
    #mysql-workbench
    remmina
    gparted

    # workaround: https://discourse.nixos.org/t/need-help-with-resolving-missing-dependencies-for-auto-patchelf-on-termius/69722/2?u=ajhalili2006
    (pkgs.termius.overrideAttrs (oldAttrs: {
      buildInputs = oldAttrs.buildInputs or [ ] ++ [ pkgs.sqlite ];
    }))
    zed-editor
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      firefoxpwa
      _1password-gui
    ];
  };
}
