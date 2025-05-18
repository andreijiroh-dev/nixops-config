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
      settings = {
        scan_timeout = 50;
        command_timeout = 3500;
      };
    };
  };

  # additional packages for use in bash shell (e.g. ble.sh)
  environment.systemPackages = with pkgs; [
    blesh
  ];
}
