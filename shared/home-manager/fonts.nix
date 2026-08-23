{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    dejavu_fonts
    cascadia-code
    fira
    jetbrains-mono
    ubuntu-sans
    ubuntu-sans-mono
    ibm-plex

    # nerd fonts (requires setting system.stateVersion to 25.05+)
    nerd-fonts.noto
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.ubuntu
  ];
}
