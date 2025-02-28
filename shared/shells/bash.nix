{ pkgs, ... }:

{
  programs.bash = {
    #enable = true;
    completion = {
      enable = true;
      package = pkgs.bash-completion;
    };
    undistractMe = {
      enable = true;
      playSound = true;
      timeout = 15;
    };
  };
}