{ pkgs, ... }:

{
  programs.starship = {
    package = pkgs.starship;
    enable = true;
    presets = [
      "nerd-font-symbols"
      "bracketed-segments"
      "no-runtime-versions"
    ];
    settings = {
      scan_timeout = 50;
      command_timeout = 15000;
      directory = {
        truncation_length = 4;
        truncation_symbol = ".../";
      };
      direnv = {
        disabled = false;
        allowed_msg = "allowed";
        not_allowed_msg = "pending";
        denied_msg = "blocked";
        loaded_msg = "loaded";
        not_loaded_msg = "unloaded";
      };
    };
  };
  
  # enable ble.sh integration for starship
  programs.bash.blesh.enable = true;

  # additional packages for use in shells (e.g. ble.sh)
  environment.systemPackages = with pkgs; [
    blesh
    starship
  ];
}