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

  # required due to security warnings
  nixpkgs.config.permittedInsecurePackages = [
    "broadcom-sta-6.30.223.271-57-6.15.7"
    "broadcom-sta-6.30.223.271-57-6.16.3"
  ];
}
