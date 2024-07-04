{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf mkDefault mkForce;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.locale;
in {
  options.${namespace}.system.locale = {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = mkDefault "en_US.UTF-8";
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = mkForce "us";
    };

    time.timeZone = mkDefault "America/Los_Angeles";
  };
}
