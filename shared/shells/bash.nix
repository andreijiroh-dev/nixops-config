{ pkgs, ... }:

{
  programs.bash = {
    enable = true;
    completion = {
      enable = true;
      package = with pkgs; [
        _1password-cli
        gh
        glab
        firefoxpwa
        doppler
      ];
    };
  };
}