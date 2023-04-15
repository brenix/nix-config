{ pkgs, ... }:
{
  home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  # home.sessionVariables.DEFAULT_BROWSER = "${pkgs.chroimium}/bin/chromium";

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
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
}
