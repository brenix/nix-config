{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.browsers.firefox;
in
{
  options.modules.browsers.firefox = {
    enable = mkEnableOption "enable firefox browser";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        name = "Default";
        settings = {
          "browser.aboutConfig.showWarning" = false;
          "browser.cache.disk.enable" = true;
          "browser.compactmode.show" = true;
          "browser.pocket.enabled" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 0;
          "browser.tabs.inTitlebar" = 0;
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","ublock0_raymondhill_net-browser-action","idcac-pub_guus_ninja-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ubolite_raymondhill_net-browser-action","support_todoist_com-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","urlbar-container","downloads-button","reset-pbm-toolbar-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","idcac-pub_guus_ninja-browser-action","support_todoist_com-browser-action","ubolite_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":20,"newElementCount":5}'';
          "browser.uidensity" = 1;
          "browser.urlbar.trimURLs" = false;
          "content.notify.interval" = 100000;
          "font.default.x-western" = "sans-serif";
          "font.name.monospace.x-western" = config.my.settings.fonts.monospace;
          "font.name.sans-serif.x-western" = config.my.settings.fonts.regular;
          "font.name.serif.x-western" = config.my.settings.fonts.regular;
          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;
          "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
          "identity.fxaccounts.enabled" = true;
          "image.mem.decode_bytes_at_a_time" = 32768;
          "layout.css.prefers-color-scheme.content-override" = 1;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;
          "media.memory_cache_max_size" = 65536;
          "network.buffer.cache.count" = 128;
          "network.buffer.cache.size" = 262144;
          "network.dns.disableIPv6" = true;
          "network.dns.max_high_priority_threads" = 16;
          "network.dnsCacheEntries" = 1000;
          "network.http.http3.enabled" = true;
          "network.http.max-connections" = 256;
          "network.http.max-persistent-connections-per-server" = 12;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.ssl_tokens_cache_capacity" = 10240;
          "network.tcp.keepalive.idle_time" = 300;
          "network.tcp.tcp_fastopen_enable" = true;
          "nglayout.initialpaint.delay_in_oopif" = 0;
          "nglayout.initialpaint.delay" = 0;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };

        userChrome = ''
          /* Hide extra icons in address bar */
          #page-action-buttons > *:not(#star-button-box),
          .urlbar-history-dropmarker {
            opacity: 0 !important;
          }

          /* START Firefox Ultra Compact Mode
          *
          * Copyright (c) Danny Colin
          *
          * This Source Code Form is subject to the terms of the Mozilla Public
          * License, v. 2.0. If a copy of the MPL was not distributed with this
          * file, You can obtain one at https://mozilla.org/MPL/2.0/.
          */

          :root {
            /* Appmenu: Reduce item padding */
            --arrowpanel-menuitem-padding-block: 4px 8px !important;
            /* Tabbar: reduce tab margin */
            --tab-block-margin: 4px 3px !important;
          }

          /* Tab: Reduce height */
          .tabbrowser-tab {
            min-height: 24px !important;
          }

          /* Tab: Ensure tab height doesn't augment when arrowscrollbox is visible  */
          #tabbrowser-arrowscrollbox {
            --tab-min-height: 31px !important;
            max-height: var(--tab-min-height);
          }

          /* URLBar: Fix vertical alignment */
          #urlbar[breakout=true]:not([open="true"]) {
            --urlbar-height: 20px !important;
            --urlbar-toolbar-height: 24px !important;
          }

          /* URLBar: Fix URL address vertical aligment when megabar is open */
          #urlbar[breakout=true][open="true"] {
            --urlbar-toolbar-height: 30px !important;
          }

          /* Searchbar: Ensure toolbar height doesn't augment when searchbar is visible */
          #urlbar-container,
          #search-container {
            padding-block: 0 !important;
          }

          /* Searchbar: Make sure the min-height of the input is the same as the popup */
          #search-container {
            min-width: 192px !important;
          }

          /* Toolbar: Reduce spacing */
          #urlbar-container {
            --urlbar-container-height: 30px !important;
            margin-top: 0 !important;
          }

          /* Reload Button: Fix vertical alignment */
          #reload-button {
            margin-block-start: -2px !important;
          }

          /* END Firefox Ultra Compact Mode */
        '';
      };
    };

    home.persistence = {
      "/persist/home/brenix" = {
        directories = [ ".mozilla/firefox" ];
        allowOther = true;
      };
    };
  };
}
