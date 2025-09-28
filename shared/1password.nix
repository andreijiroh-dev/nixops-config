{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [
      "gildedguy"
      "ajhalili2006"
      "MFHellscapes"
      "halilifam"
    ];
  };

  # HACK: Allow zen-browser and vivaldi to be used with 1Password
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen

        vivaldi
      '';
      mode = "0755";
    };
  };
}
