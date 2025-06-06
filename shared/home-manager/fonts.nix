{ pkgs, ... }:

{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    dejavu_fonts
    cascadia-code

    # nerd fonts (requires setting system.stateVersion to 25.05+)
    nerd-fonts.fira-code
    nerd-fonts.caskaydia-mono
    nerd-fonts.caskaydia-cove
  ];
}