{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkMerge;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.input;
in {
  options.${namespace}.system.input = {
    enable = mkBoolOpt false "Enable macOS input tweaks";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      system = {
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        defaults = {
          NSGlobalDomain = {
            AppleKeyboardUIMode = 3;
            ApplePressAndHoldEnabled = false;

            KeyRepeat = 2;
            InitialKeyRepeat = 15;

            NSAutomaticCapitalizationEnabled = false;
            NSAutomaticDashSubstitutionEnabled = false;
            NSAutomaticQuoteSubstitutionEnabled = false;
            NSAutomaticPeriodSubstitutionEnabled = false;
            NSAutomaticSpellingCorrectionEnabled = false;
          };
        };
      };
    }
  ]);
}
