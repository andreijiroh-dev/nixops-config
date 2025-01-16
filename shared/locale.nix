{ config, pkgs, lib, ... }:

{
  # Set your time zone.
  time = {
    timeZone = "Asia/Manila";
    # since we're no longer being taken ahold by Windows 11 slavery in terms of hw clock
    # confusion, we cn set this to false to use UTC.
    hardwareClockInLocalTime = false;
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_PH.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_PH.UTF-8";
      LC_IDENTIFICATION = "en_PH.UTF-8";
      LC_MEASUREMENT = "en_PH.UTF-8";
      LC_MONETARY = "en_PH.UTF-8";
      LC_NAME = "en_PH.UTF-8";
      LC_NUMERIC = "en_PH.UTF-8";
      LC_PAPER = "en_PH.UTF-8";
      LC_TELEPHONE = "en_PH.UTF-8";
      LC_TIME = "en_PH.UTF-8";
    };
    supportedLocales = [
      "all" # bless anyone here
    ];
  };
}