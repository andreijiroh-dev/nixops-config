{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        nativeMessagingHosts.packages = with pkgs; [
            firefoxpwa
        #    _1password-gui
        #    gnupg
        ];
        package = pkgs.firefox;
    };
}
