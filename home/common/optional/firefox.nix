{ config, pkgs, lib, inputs, ... }:
let
  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-beta;
    profiles.brenix = {
      extensions = with addons; [
        bitwarden
        decentraleyes
        h264ify
        # i-still-dont-care-about-cookies
        # imagus
        theme-nord-polar-night
        ublock-origin
        vimium
      ];
      /* bookmarks = { }; */
      settings = {
        "app.normandy.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "app.update.auto" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.backspace_action" = 0;
        "browser.cache.disk.parent_directory" = "/run/user/1000/firefox";
        "browser.compactmode.show" = true;
        "browser.disableResetPrompt" = true;
        "browser.discovery.enabled" = false;
        "browser.fixup.alternate.enabled" = false;
        "browser.formfill.enable" = false;
        "browser.library.activity-stream.enabled" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.onboarding.enabled" = false;
        "browser.pagethumbnails.capturing_disabled" = true;
        "browser.ping-centre.telemetry" = false;
        "browser.pocket.enabled" = false;
        "browser.search.widget.inNavBar" = false;
        "browser.sessionstore.interval" = 60000;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.shell.defaultBrowserCheckCount" = 1;
        "browser.startup.homepage" = "about:blank";
        "browser.startup.page" = 0;
        "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":["87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","ublock0_raymondhill_net-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","urlbar-container","downloads-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list"],"currentVersion":17,"newElementCount":3}'';
        "browser.uidensity" = 1;
        "browser.urlbar.clickSelectsAll" = true;
        "browser.urlbar.trimURLs" = false;
        "browser.urlbar.update1" = false;
        "browser.xul.error_pages.enabled" = false;
        "browser.zoom.full" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.sessions.current.clean" = true;
        "devtools.onboarding.telemetry.logged" = false;
        "extensions.autoDisableScopes" = 0;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        "extensions.getAddons.discovery.api_url" = "";
        "extensions.getAddons.showPane" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.screenshots.upload-disabled" = true;
        "findbar.highlightAll" = true;
        "findbar.modalHighlight" = true;
        "font.default.x-western" = "sans-serif";
        "font.name.monospace.x-western" = config.fontProfiles.monospace.family;
        "font.name.sans-serif.x-western" = config.fontProfiles.regular.family;
        "font.name.serif.x-western" = config.fontProfiles.regular.family;
        "full-screen-api.warning.timeout" = 0;
        "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
        "identity.fxaccounts.enabled" = true;
        "layout.css.backdrop-filter.enabled" = true;
        "layout.css.devPixelsPerpx" = 1;
        "layout.frame_rate" = 144;
        "layout.spellcheckDefault" = 2;
        "layout.word_select.eat_space_to_next_word" = false;
        "loop.enabled" = false;
        "media.mediasource.webm.enabled" = true;
        "network.IDN_show_punycode" = true;
        "network.dns.disableIPv6" = true;
        "network.dnsCacheEntries" = 10000;
        "network.http.http3.enabled" = true;
        "network.http.max-persistent-connections-per-server" = 32;
        "network.http.max-urgent-start-excessive-connections-per-host" = 6;
        "network.proxy.socks_remote_dns" = true;
        "network.tcp.keepalive.idle_time" = 300;
        "network.tcp.tcp_fastopen_enable" = true;
        "plugin.state.flash" = 0;
        "plugins.click_to_play" = true;
        "privacy.trackingprotection.cryptomining.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.userContext.ui.enabled" = true;
        "privacy.usercontext.about_newtab_segregation.enabled" = true;
        "reader.parse-on-load.enabled" = false;
        "reader.parse-on-load.force-enabled" = false;
        "security.enterprise_roots.enabled" = true;
        "security.webauthn.ctap2" = true;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "svg.context-properties.content.enabled" = true;
        "toolkit.cosmeticAnimations.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.zoomManager.zoomValues" = ".3,.5,.67,.8,.9,1,1.05,1.1,1.2,1.33,1.5,1.7,2,2.4,3,4,5";
      };
      userChrome = ''
        /* Hide extra icons in address bar */
        #page-action-buttons > *:not(#star-button-box),
        .urlbar-history-dropmarker {
          opacity: 0 !important;
        }

        /* Hide forward and back buttons */
        #back-button,
        #forward-button {
          display: none !important;
        }

        /* Hide the microphone indicator */
        #webrtcIndicator {
          display: none;
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
}
