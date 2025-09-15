{ ... }:

{
  # AppImages supprot via binfmt_misc
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}