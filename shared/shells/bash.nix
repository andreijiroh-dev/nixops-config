{ pkgs, ... }:

{
  config = {
    programs.bash = {
      completion = {
        enable = true;
        package = pkgs.bash-completion;
      };
    };
  };
}
