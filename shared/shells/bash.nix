{ pkgs, ... }:

{
  programs = {
    bash = {
      completion = {
        enable = true;
        package = pkgs.bash-completion;
      };
    };
  };
}
