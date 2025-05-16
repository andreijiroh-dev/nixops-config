{ pkgs, ... }:

{
  programs = {
    bash = {
      completion = {
        enable = true;
        package = pkgs.bash-completion;
      };
    };
    starship = {
      package = pkgs.starship;
      enable = true;
      presets = [
        "nerd-font-symbols"
        "bracketed-segments"
      ];
    };
  };
}
