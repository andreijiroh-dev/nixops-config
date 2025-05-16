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
      enable = true;
      presets = [
        "nerd-font-symbols"
        "bracketed-segments"
      ];
    };
  };
}
