{ pkgs, ... }:

{
    programs.firefox = {
        enable = true;
        nativeMessagingHosts.packages = with pkgs; [
            firefoxpwa
            _1password-gui
            _1password-cli
            gnupg
        ];
        package = pkgs.firefox;
    };
}
