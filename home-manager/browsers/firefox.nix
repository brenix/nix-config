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
      package = pkgs.firefox-beta;
      profiles.default = {
        name = "Default";
        settings = {
          "app.update.auto" = false;
          "browser.backspace_action" = 0;
          "browser.disableResetPrompt" = true;
          "browser.fixup.alternate.enabled" = false;
          "browser.library.activity-stream.enabled" = false;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.enabled" = false;
          "browser.onboarding.enabled" = false;
          "browser.pagethumbnails.capturing_disabled" = true;
          "browser.pocket.enabled" = false;
          "browser.search.widget.inNavBar" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 0;
          "browser.uiCustomization.state" = ''{"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","ublock0_raymondhill_net-browser-action","idcac-pub_guus_ninja-browser-action"],"nav-bar":["back-button","forward-button","stop-reload-button","home-button","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","ubolite_raymondhill_net-browser-action","support_todoist_com-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","urlbar-container","downloads-button","reset-pbm-toolbar-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","ublock0_raymondhill_net-browser-action","87677a2c52b84ad3a151a4a72f5bd3c4_jetpack-browser-action","aws-extend-switch-roles_toshi_tilfin_com-browser-action","sort-bookmarks_heftig-browser-action","_96586e48-b9a2-45dd-b1a1-54fa85a97c91_-browser-action","_a4c4eda4-fb84-4a84-b4a1-f7c1cbf2a1ad_-browser-action","_d7742d87-e61d-4b78-b8a1-b469842139fa_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","jid1-tsgsxbhncspbwq_jetpack-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","idcac-pub_guus_ninja-browser-action","support_todoist_com-browser-action","ubolite_raymondhill_net-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","widget-overflow-fixed-list","unified-extensions-area"],"currentVersion":20,"newElementCount":5}'';
          "browser.uidensity" = 1;
          "browser.urlbar.clickSelectsAll" = true;
          "browser.urlbar.trimURLs" = false;
          "browser.urlbar.update1" = false;
          "browser.xul.error_pages.enabled" = false;
          "browser.zoom.full" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "dom.iframe_lazy_loading.enabled" = true;
          "extensions.autoDisableScopes" = 0;
          "extensions.formautofill.available" = "off";
          "extensions.getAddons.discovery.api_url" = "";
          "extensions.htmlaboutaddons.discover.enabled" = false;
          "extensions.screenshots.upload-disabled" = true;
          "findbar.modalHighlight" = true;
          "font.default.x-western" = "sans-serif";
          "font.name.monospace.x-western" = config.my.settings.fonts.monospace;
          "font.name.sans-serif.x-western" = config.my.settings.fonts.regular;
          "font.name.serif.x-western" = config.my.settings.fonts.regular;
          "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
          "layout.css.backdrop-filter.enabled" = true;
          "layout.css.devPixelsPerpx" = 1;
          "layout.spellcheckDefault" = 2;
          "layout.word_select.eat_space_to_next_word" = false;
          "loop.enabled" = false;
          "media.mediasource.webm.enabled" = true;
          "network.dns.disableIPv6" = true;
          "network.http.http3.enabled" = true;
          "network.tcp.keepalive.idle_time" = 300;
          "network.tcp.tcp_fastopen_enable" = true;
          "plugin.state.flash" = 0;
          "plugins.click_to_play" = true;
          "privacy.trackingprotection.cryptomining.enabled" = true;
          "privacy.trackingprotection.enabled" = true;
          "privacy.userContext.enabled" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "reader.parse-on-load.enabled" = false;
          "reader.parse-on-load.force-enabled" = false;
          "security.enterprise_roots.enabled" = true;
          "security.webauthn.ctap2" = true;
          "svg.context-properties.content.enabled" = true;
          "toolkit.cosmeticAnimations.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "ui.systemUsesDarkTheme" = false;

          /* The remaining sections were takenfrom yokoffing/Betterfox */

          # FASTFOX
          "nglayout.initialpaint.delay" = 0;
          "nglayout.initialpaint.delay_in_oopif" = 0;
          "content.notify.interval" = 100000;

          "layout.css.grid-template-masonry-value.enabled" = true;
          "dom.enable_web_task_scheduling" = true;
          "layout.css.has-selector.enabled" = true;
          "dom.security.sanitizer.enabled" = true;

          "gfx.canvas.accelerated.cache-items" = 4096;
          "gfx.canvas.accelerated.cache-size" = 512;
          "gfx.content.skia-font-cache-size" = 20;

          "browser.cache.disk.enable" = false;

          "media.memory_cache_max_size" = 65536;
          "media.cache_readahead_limit" = 7200;
          "media.cache_resume_threshold" = 3600;

          "image.mem.decode_bytes_at_a_time" = 32768;

          "network.buffer.cache.size" = 262144;
          "network.buffer.cache.count" = 128;
          "network.http.max-connections" = 1800;
          "network.http.max-persistent-connections-per-server" = 10;
          "network.http.max-urgent-start-excessive-connections-per-host" = 5;
          "network.http.pacing.requests.enabled" = false;
          "network.dnsCacheEntries" = 1000;
          "network.dnsCacheExpiration" = 86400;
          "network.dns.max_high_priority_threads" = 8;
          "network.ssl_tokens_cache_capacity" = 10240;

          "network.http.speculative-parallel-limit" = 0;
          "network.dns.disablePrefetch" = true;
          "browser.urlbar.speculativeConnect.enabled" = false;
          "browser.places.speculativeConnect.enabled" = false;
          "network.prefetch-next" = false;
          "network.predictor.enabled" = false;
          "network.predictor.enable-prefetch" = false;

          # SECUREFOX
          "browser.contentblocking.category" = "strict";
          "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com";
          "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
          "privacy.partition.bloburl_per_partition_key" = true;
          "browser.uitour.enabled" = false;
          "privacy.globalprivacycontrol.enabled" = true;
          "privacy.globalprivacycontrol.functionality.enabled" = true;

          "security.OCSP.enabled" = 0;
          "security.remote_settings.crlite_filters.enabled" = true;
          "security.pki.crlite_mode" = 2;
          "security.cert_pinning.enforcement_level" = 2;

          "security.ssl.treat_unsafe_negotiation_as_broken" = true;
          "browser.xul.error_pages.expert_bad_cert" = true;
          "security.tls.enable_0rtt_data" = false;

          "browser.privatebrowsing.forceMediaMemoryCache" = true;
          "browser.sessionstore.interval" = 60000;

          "privacy.history.custom" = true;

          "browser.search.separatePrivateDefault.ui.enabled" = true;
          "browser.urlbar.update2.engineAliasRefresh" = true;
          "browser.search.suggest.enabled" = false;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
          "browser.formfill.enable" = false;
          "security.insecure_connection_text.enabled" = true;
          "security.insecure_connection_text.pbmode.enabled" = true;
          "network.IDN_show_punycode" = true;

          "dom.security.https_first" = true;

          "signon.rememberSignons" = false;
          "editor.truncate_user_pastes" = false;

          "extensions.formautofill.addresses.enabled" = false;
          "extensions.formautofill.creditCards.enabled" = false;

          "network.auth.subresource-http-auth-allow" = 1;
          "security.mixed_content.block_display_content" = true;
          "pdfjs.enableScripting" = false;
          "extensions.postDownloadThirdPartyPrompt" = false;

          "network.http.referer.XOriginTrimmingPolicy" = 2;

          "privacy.userContext.ui.enabled" = true;

          "media.peerconnection.ice.proxy_only_if_behind_proxy" = true;
          "media.peerconnection.ice.default_address_only" = true;

          "browser.safebrowsing.downloads.remote.enabled" = false;

          "identity.fxaccounts.enabled" = true;
          "browser.tabs.firefox-view" = false;
          "permissions.default.desktop-notification" = 2;
          "permissions.default.geo" = 0;
          "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
          "permissions.manager.defaultsUrl" = "";
          "webchannel.allowObject.urlWhitelist" = "";

          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.server" = "data:,";
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.coverage.opt-out" = true;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "breakpad.reportURL" = "";
          "browser.tabs.crashReporting.sendReport" = false;
          "browser.crashReports.unsubmittedCheck.autoSubmit2" = false;
          "captivedetect.canonicalURL" = "";
          "network.captive-portal-service.enabled" = false;
          "network.connectivity-service.enabled" = false;
          "app.normandy.enabled" = false;
          "app.normandy.api_url" = "";
          "browser.ping-centre.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;

          # PESKYFOX
          "layout.css.prefers-color-scheme.content-override" = 1;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "app.update.suppressPrompts" = true;
          "browser.compactmode.show" = true;
          "browser.privatebrowsing.vpnpromourl" = "";
          "extensions.getAddons.showPane" = false;
          "extensions.htmlaboutaddons.recommendations.enabled" = false;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.preferences.moreFromMozilla" = false;
          "browser.tabs.tabmanager.enabled" = false;
          "browser.aboutConfig.showWarning" = false;
          "browser.aboutwelcome.enabled" = false;
          "browser.display.focus_ring_on_anything" = true;
          "browser.display.focus_ring_style" = 0;
          "browser.display.focus_ring_width" = 0;
          "browser.privateWindowSeparation.enabled" = false;
          "cookiebanners.service.mode" = 2;
          "cookiebanners.service.mode.privateBrowsing" = 2;
          "browser.translations.enable" = true;

          "full-screen-api.transition-duration.enter" = "0 0";
          "full-screen-api.transition-duration.leave" = "0 0";
          "full-screen-api.warning.delay" = -1;
          "full-screen-api.warning.timeout" = 0;

          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.topsites" = false;
          "browser.urlbar.suggest.calculator" = true;
          "browser.urlbar.unitConversion.enabled" = true;

          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

          "extensions.pocket.enabled" = false;

          "browser.download.useDownloadDir" = false;
          "browser.download.always_ask_before_handling_new_types" = true;
          "browser.download.alwaysOpenPanel" = false;
          "browser.download.manager.addToRecentDocs" = false;

          "browser.download.open_pdf_attachments_inline" = true;
          "pdfjs.sidebarViewOnLoad" = 2;

          "browser.bookmarks.openInTabClosesMenu" = false;
          "browser.menu.showViewImageInfo" = true;
          "findbar.highlightAll" = true;
        };

        userChrome = ''
          /* Hide extra icons in address bar */
          #page-action-buttons > *:not(#star-button-box),
          .urlbar-history-dropmarker {
            opacity: 0 !important;
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
  };
}
