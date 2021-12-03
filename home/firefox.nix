{ pkgs, ... }: {

  imports = [
    ../modules/settings.nix
  ];

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        decentraleyes
        bitwarden
        ublock-origin
        grammarly
        h264ify
    ];
    profiles.default = {
        settings = {
          "app.normandy.enabled" = false;
          "app.shield.optoutstudies.enabled" = false;
          "browser.backspace_action" = 0;
          "browser.cache.disk.parent_directory" = "/run/user/1000/firefox";
          "browser.compactmode.show" = true;
          "browser.discovery.enabled" = false;
          "browser.fixup.alternate.enabled" = false;
          "browser.formfill.enable" = false;
          "browser.library.activity-stream.enabled" = false;
          "browser.newtab.preload" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.newtabpage.activity-stream.disableSnippets" = true;
          "browser.newtabpage.activity-stream.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.newtabpage.activity-stream.showSearch" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry.ping.endpoint" = "";
          "browser.newtabpage.directory.source" = "data:text/plain ={}";
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.enhanced" = false;
          "browser.newtabpage.introShown" = true;
          "browser.onboarding.enabled" = false;
          "browser.pagethumbnails.capturing_disabled" = true;
          "browser.pocket.enabled" = false;
          "browser.search.widget.inNavBar" = false;
          "browser.sessionstore.interval" = 60000;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 0;
          "browser.urlbar.clickSelectsAll" = true;
          "browser.urlbar.trimURLs" = false;
          "browser.urlbar.update1" = false;
          "browser.xul.error_pages.enabled" = false;
          "dom.webgpu.enabled" = true;
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
          "font.name.monospace.x-western" = "Hack Nerd Font Mono";
          "font.name.sans-serif.x-western" = "Verdana";
          "font.name.serif.x-western" = "Verdana";
          "full-screen-api.warning.timeout" = 0;
          "general.warnOnAboutConfig" = false;
          "gfx.canvas.azure.accelerated" = true;
          "gfx.font_rendering.fontconfig.max_generic_substitutions" = 127;
          "gfx.webrender.all" = true;
          "gfx.webrender.enabled" = true;
          "javascript.options.warp" = true;
          "layers.acceleration.force-enabled" = true;
          "layout.css.backdrop-filter.enabled" = true;
          "layout.css.devPixelsPerpx" = 1;
          "layout.spellcheckDefault" = 2;
          "layout.word_select.eat_space_to_next_word" = false;
          "loop.enabled" = false;
          "media.mediasource.webm.enabled" = true;
          "media.navigator.enabled" = false;
          "media.navigator.video.enabled" = false;
          "media.peerconnection.enabled" = false;
          "media.peerconnection.identity.enabled" = false;
          "media.peerconnection.video.enabled" = false;
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
          "privacy.userContext.enabled" = true;
          "privacy.userContext.ui.enabled" = true;
          "privacy.usercontext.about_newtab_segregation.enabled" = true;
          "reader.parse-on-load.enabled" = false;
          "reader.parse-on-load.force-enabled" = false;
          "security.enterprise_roots.enabled" = true;
          "signon.autofillForms" = false;
          "signon.rememberSignons" = false;
          "svg.context-properties.content.enabled" = true;
          "toolkit.cosmeticAnimations.enabled" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
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
}
