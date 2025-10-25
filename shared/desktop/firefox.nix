{ pkgs, inputs, ... }:

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
    inputs.zen-browser.packages.${pkgs.system}.default
  ];
}
