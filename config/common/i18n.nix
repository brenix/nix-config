{ config, ... }: {
  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
    font = "Lat2-Terminus16";
  };
}
