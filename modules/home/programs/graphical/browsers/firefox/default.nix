{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  inherit (config.lib.stylix) colors;

  cfg = config.${namespace}.programs.graphical.browsers.firefox;
in {
  options.${namespace}.programs.graphical.browsers.firefox = {
    enable = mkBoolOpt false "enable firefox browser";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };

    textfox = with colors; {
      enable = false;
      profile = "default";
      config = {
        background.color = "#${base00}";
        border = {
          color = "#${base06}";
          width = "1px";
          radius = "0px";
        };
        displayWindowControls = false;
        displayNavButtons = true;
        displayTitles = false;
        newtabLogo =
          # text
          ''
              __ _           __
             / _(_)_ __ ___ / _| _____  __
            | |_| | '__/ _ \ |_ / _ \ \/ /
            |  _| | | |  __/  _| (_) >  <
            |_| |_|_|  \___|_|  \___/_/\_\

          '';
        font = {
          # family = config.stylix.fonts.monospace.name;
          family = "Terminus";
          size = "12px";
          accent = "#${base06}";
        };
      };
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          decentraleyes
          istilldontcareaboutcookies
          linkding-extension
          onepassword-password-manager
        ];
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.pocket.enabled" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 0;
          "browser.tabs.inTitlebar" = 0;
          "browser.uidensity" = 1;
          "browser.urlbar.trimURLs" = false;
          "font.default.x-western" = "sans-serif";
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
          "gnomeTheme.activeTabContrast" = true;
          "gnomeTheme.hideSingleTab" = false;
          "gnomeTheme.hideWebrtcIndicator" = true;
          "gnomeTheme.spinner" = true;
          "gnomeTheme.systemIcons" = true;
          "identity.fxaccounts.enabled" = true;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "layers.acceleration.force-enabled" = true;
          "layout.css.prefers-color-scheme.content-override" = 2;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "media.memory_cache_max_size" = 65536;
          "network.buffer.cache.count" = 128;
          "network.buffer.cache.size" = 262144;
          "network.dns.disableIPv6" = true;
          "network.dns.max_high_priority_threads" = 16;
          "network.dnsCacheEntries" = 20000;
          "network.http.http3.enabled" = true;
          "network.http.max-connections" = 256;
          "network.http.max-persistent-connections-per-server" = 12;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.ssl_tokens_cache_capacity" = 10240;
          "network.tcp.keepalive.idle_time" = 300;
          "network.tcp.tcp_fastopen_enable" = true;
          "nglayout.initialpaint.delay" = 0;
          "nglayout.initialpaint.delay_in_oopif" = 0;
          "sidebar.ansibmation.enabled" = false;
          "sidebar.main.tools" = null;
          "sidebar.revamp" = true;
          "sidebar.verticalTabs" = false;
          "sidebar.visibility" = "always-show";
          "svc.context-properties.content.enabled" = true;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "widget.non-native-theme.use-theme-accent" = true;
        };
      };
    };
  };
}
