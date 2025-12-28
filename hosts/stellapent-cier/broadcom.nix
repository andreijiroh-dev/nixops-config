{ self, config, pkgs, lib, ... }:

{
  # load broadcom wireless driver
  boot.kernelModules = [ "wl" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];
  
  # blacklist similar modules to avoid collision
  boot.blacklistedKernelModules = [ "b43" "bcma" ];

  hardware.firmware = with pkgs; [
    broadcom-bt-firmware
  ];

  # required due to security warnings, also maintained here for reproducibility instead of
  # messing around --impure CLI flag + exporting NIXPKGS_ALLOW_INSECURE=1
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.15.7"
    "broadcom-sta-6.30.223.271-57-6.16.3"
    "broadcom-sta-6.30.223.271-57-6.16.4"
    "broadcom-sta-6.30.223.271-57-6.16.5"
    "broadcom-sta-6.30.223.271-57-6.16.6"
    "broadcom-sta-6.30.223.271-57-6.16.7"
    "broadcom-sta-6.30.223.271-57-6.16.8"
    "broadcom-sta-6.30.223.271-59-6.17.7"
    "broadcom-sta-6.30.223.271-59-6.18"
    "broadcom-sta-6.30.223.271-59-6.18.2"
  ];
}
