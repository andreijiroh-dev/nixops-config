{ config, ... }:

{
  # AppImages supprot via binfmt_misc
  config.programs.appimage = {
    enable = true;
    binfmt = true;
  };
}