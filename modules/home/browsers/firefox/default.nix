{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.browsers.firefox;
in {
  options.browsers.firefox = {
    enable = mkEnableOption "enable firefox browser";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps.defaultApplications = {
      "text/html" = ["firefox.desktop"];
      "text/xml" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
    };

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          # bitwarden
          decentraleyes
          istilldontcareaboutcookies
          linkding-extension
          onepassword-password-manager
          ublock-origin-lite
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
          "layout.css.prefers-color-scheme.content-override" = 1;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "media.memory_cache_max_size" = 65536;
          "network.buffer.cache.count" = 128;
          "network.buffer.cache.size" = 262144;
          "network.dnsCacheEntries" = 1000;
          "network.dns.disableIPv6" = true;
          "network.dns.max_high_priority_threads" = 16;
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
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
