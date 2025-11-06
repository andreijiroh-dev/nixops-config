{ pkgs, zen-browser, ... }:

{
  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = with pkgs; [
      firefoxpwa
      #    _1password-gui
      #    gnupg
    ];
    package = pkgs.firefox;
  };

  environment.systemPackages = [
    zen-browser.packages.${pkgs.system}.default
  ];
}
