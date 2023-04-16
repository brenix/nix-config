{ config, pkgs, ... }:
{
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  # home.sessionVariables.DEFAULT_BROWSER = "${pkgs.chroimium}/bin/chromium";

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      # "text/html" = "chromium-browser.desktop";
      # "x-scheme-handler/http" = "chromium-browser.desktop";
      # "x-scheme-handler/https" = "chromium-browser.desktop";
      # "x-scheme-handler/about" = "chromium-browser.desktop";
      # "x-scheme-handler/unknown" = "chromium-browser.desktop";
    };
  };

  xdg.userDirs = {
    enable = true;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/templates";
    videos = "${config.home.homeDirectory}/videos";
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        "downloads"
      ];
      allowOther = true;
    };
  };
}
