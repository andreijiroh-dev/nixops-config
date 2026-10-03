{ pkgs, config, ... }:

{
  config = {
    # enable font dirs
    fonts = {
      # Expose all fonts under /run/current-system/sw/share/X11/fonts
      fontDir.enable = true;
      # TODO: Sync packages with those on my home-manager config
      packages = with pkgs; [
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
    };
};
}
