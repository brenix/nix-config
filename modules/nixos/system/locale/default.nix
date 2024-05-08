{
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.system.locale;
in {
  options.system.locale = with types; {
    enable = mkBoolOpt false "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
    };

    console = {
      font = "Lat2-Terminus16";
      keyMap = mkForce "us";
    };

    time.timeZone = lib.mkDefault "America/Los_Angeles";
  };
}
