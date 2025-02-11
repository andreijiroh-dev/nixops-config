{ pkgs, ... }:

{
    # install firefox
    programs.firefox.{
        enable = true;
        nativeMessagingHosts.packages = with pkgs; [ firefoxpwa ];
        package = pkgs.firefox;
    }
}
