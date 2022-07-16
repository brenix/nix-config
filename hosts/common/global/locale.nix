{ lib, ... }:
{
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = { LC_CTYPE = "en_US.UTF-8"; };
  };

  time.timeZone = lib.mkDefault "America/Los_Angeles";

  console = {
    useXkbConfig = true;
    font = "Lat2-Terminus16";
  };
}
