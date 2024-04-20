{ inputs
, lib
, config
, ...
}:
with lib; let
  cfg = config.browsers.firefox;
in
{
  options.browsers.firefox = {
    enable = mkEnableOption "enable firefox browser";
  };

  config = mkIf cfg.enable {
    home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        extraConfig = ''
          ${builtins.readFile "${inputs.firefox-gnome-theme}/configuration/user.js"}
        '';

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

        userChrome = ''
          @import "firefox-gnome-theme/userChrome.css";

          :root {{
          --gnome-browser-before-load-background:        rgb(30, 30, 46)};
          --gnome-accent-bg:                             rgb(137, 180, 250);
          --gnome-accent:                                rgb(116, 199, 236);
          --gnome-toolbar-background:                    rgb(30, 30, 46);
          --gnome-toolbar-color:                         rgb(205, 214, 244);
          --gnome-toolbar-icon-fill:                     rgb(205, 214, 244);
          --gnome-inactive-toolbar-color:                rgb(30, 30, 46);
          --gnome-inactive-toolbar-border-color:         rgb(49, 50, 68);
          --gnome-inactive-toolbar-icon-fill:            rgb(205, 214, 244);
          --gnome-menu-background:                       rgb(24, 24, 37);
          --gnome-headerbar-background:                  rgb(17, 17, 27);
          --gnome-button-destructive-action-background:  rgb(237, 135, 150);
          --gnome-entry-color:                           rgb(205, 214, 244);
          --gnome-inactive-entry-color:                  rgb(205, 214, 244);
          --gnome-switch-slider-background:              rgb(24, 24, 37);
          --gnome-switch-active-slider-background:       rgb(116, 199, 236);
          --gnome-inactive-tabbar-tab-background:        rgb(30, 30, 46);
          --gnome-inactive-tabbar-tab-active-background: rgba(255,255,255,0.025);
          --gnome-tabbar-tab-background:                 rgb(30, 30, 46);
          --gnome-tabbar-tab-hover-background:           rgba(255,255,255,0.025);
          --gnome-tabbar-tab-active-background:          rgba(255,255,255,0.075);
          --gnome-tabbar-tab-active-hover-background:    rgba(255,255,255,0.100);
          --gnome-tabbar-tab-active-background-contrast: rgba(255,255,255,0.125);
          }}

          @-moz-document url-prefix(about:home), url-prefix(about:newtab) {{
          body{{
          --newtab-background-color: #2A2A2E!important;
          --newtab-border-primary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-border-secondary-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-button-primary-color: #0060DF!important;
          --newtab-button-secondary-color: #38383D!important;
          --newtab-element-active-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-element-hover-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-icon-primary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-icon-secondary-color: rgba(249, 249, 250, 0.4)!important;
          --newtab-icon-tertiary-color: rgba(249, 249, 250, 0.4)!important;
          --newtab-inner-box-shadow-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-link-primary-color: var(--gnome-accent)!important;
          --newtab-link-secondary-color: #50BCB6!important;
          --newtab-text-conditional-color: #F9F9FA!important;
          --newtab-text-primary-color: var(--gnome-accent)!important;
          --newtab-text-secondary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-textbox-background-color: var(--gnome-toolbar-background)!important;
          --newtab-textbox-border: var(--gnome-inactive-toolbar-border-color)!important;
          --newtab-textbox-focus-color: #45A1FF!important;
          --newtab-textbox-focus-boxshadow: 0 0 0 1px #45A1FF, 0 0 0 4px rgba(69, 161, 255, 0.3)!important;
          --newtab-feed-button-background: #38383D!important;
          --newtab-feed-button-text: #F9F9FA!important;
          --newtab-feed-button-background-faded: rgba(56, 56, 61, 0.6)!important;
          --newtab-feed-button-text-faded: rgba(249, 249, 250, 0)!important;
          --newtab-feed-button-spinner: #D7D7DB!important;
          --newtab-contextmenu-background-color: #4A4A4F!important;
          --newtab-contextmenu-button-color: #2A2A2E!important;
          --newtab-modal-color: #2A2A2E!important;
          --newtab-overlay-color: rgba(12, 12, 13, 0.8)!important;
          --newtab-section-header-text-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-section-navigation-text-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-section-active-contextmenu-color: #FFF!important;
          --newtab-search-border-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-search-dropdown-color: #38383D!important;
          --newtab-search-dropdown-header-color: #4A4A4F!important;
          --newtab-search-header-background-color: rgba(42, 42, 46, 0.95)!important;
          --newtab-search-icon-color: rgba(249, 249, 250, 0.6)!important;
          --newtab-search-wordmark-color: #FFF!important;
          --newtab-topsites-background-color: #38383D!important;
          --newtab-topsites-icon-shadow: none!important;
          --newtab-topsites-label-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-card-active-outline-color: var(--gnome-toolbar-icon-fill)!important;
          --newtab-card-background-color: var(--gnome-toolbar-background)!important;
          --newtab-card-hairline-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-card-placeholder-color: #4A4A4F!important;
          --newtab-card-shadow: 0 1px 8px 0 rgba(12, 12, 13, 0.2)!important;
          --newtab-snippets-background-color: #38383D!important;
          --newtab-snippets-hairline-color: rgba(255, 255, 255, 0.1)!important;
          --trailhead-header-text-color: rgba(255, 255, 255, 0.6)!important;
          --trailhead-cards-background-color: rgba(12, 12, 13, 0.1)!important;
          --trailhead-card-button-background-color: rgba(12, 12, 13, 0.3)!important;
          --trailhead-card-button-background-hover-color: rgba(12, 12, 13, 0.5)!important;
          --trailhead-card-button-background-active-color: rgba(12, 12, 13, 0.7)!important;
        '';

        userContent = ''
          @import "firefox-gnome-theme/userContent.css;
        '';
      };
    };
  };
}
