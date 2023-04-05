{ lib, pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./chromium.nix
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./playerctl.nix
    ./qt.nix
    ./xresources.nix
  ];

  xdg.mimeApps.enable = true;
  xdg.mimeApps.defaultApplications = {
    # "text/html" = "firefox.desktop";
    # "x-scheme-handler/http" = "firefox.desktop";
    # "x-scheme-handler/https" = "firefox.desktop";
    # "x-scheme-handler/about" = "firefox.desktop";
    # "x-scheme-handler/unknown" = "firefox.desktop";
    "text/html" = "chromium-browser.desktop";
    "x-scheme-handler/http" = "chromium-browser.desktop";
    "x-scheme-handler/https" = "chromium-browser.desktop";
    "x-scheme-handler/about" = "chromium-browser.desktop";
    "x-scheme-handler/unknown" = "chromium-browser.desktop";
  };

  # home.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  # home.sessionVariables.DEFAULT_BROWSER = "${pkgs.chroimium}/bin/chromium";

  home.packages = with pkgs; [
    authy
    obsidian
    pavucontrol
    piper
    slack
    spotify
    wootility-lekker
    xdg-utils
    zoom-us
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/obsidian"
        ".config/Slack"
        ".config/spotify"
        ".config/wootility-lekker"
        ".zoom"
        ".config/Unknown Organization" # Zoom
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
      ];
      allowOther = true;
    };
  };
}
