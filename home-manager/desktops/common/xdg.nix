{ config, lib, ... }:
let
  browser = config.my.settings.default.browser;
in
{
  home.sessionVariables.DEFAULT_BROWSER = browser;

  xdg = lib.mkIf (!config.my.settings.headless) {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.cache";

    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/x-extension-htm" = browser;
        "application/x-extension-html" = browser;
        "application/x-extension-shtml" = browser;
        "application/x-extension-xht" = browser;
        "application/x-extension-xhtml" = browser;
        "application/xhtml+xml" = browser;
        "text/html" = browser;
        "x-scheme-handler/about" = browser;
        "x-scheme-handler/chrome" = [ "chromium-browser.desktop" ];
        "x-scheme-handler/ftp" = browser;
        "x-scheme-handler/http" = browser;
        "x-scheme-handler/https" = browser;
        "x-scheme-handler/unknown" = browser;
        "application/pdf" = browser;
        "x-scheme-handler/discord" = [ "discord.desktop" ];
        "x-scheme-handler/spotify" = [ "spotify.desktop" ];
        "x-scheme-handler/slack" = [ "slack.desktop" ];
        "x-scheme-handler/zoom" = [ "Zoom.desktop" ];
        "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
      };
    };

    userDirs = {
      enable = true;
      createDirectories = false;
      desktop = "${config.home.homeDirectory}/";
      documents = "${config.home.homeDirectory}/";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/";
      pictures = "${config.home.homeDirectory}/";
      templates = "${config.home.homeDirectory}/";
      videos = "${config.home.homeDirectory}/";
    };
  };
}
