{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.emulators.wezterm;
in {
  options.${namespace}.programs.terminal.emulators.wezterm = {
    enable = mkBoolOpt false "Whether or not to enable wezterm.";
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      package = pkgs.wezterm;
      extraConfig =
        # lua
        ''
          return {
            -- general
            audible_bell = "Disabled",
            check_for_updates = false,
            enable_scroll_bar = false,
            exit_behavior = "CloseOnCleanExit",
            warn_about_missing_glyphs =  false,
            term = "xterm-256color",

            -- anims
            animation_fps = 1,

            -- Color scheme
            -- color_schemes = {
            --   ["Catppuccin"] = custom,
            -- },
            -- color_scheme = "Catppuccin",

            -- Cursor
            cursor_blink_ease_in = 'Constant',
            cursor_blink_ease_out = 'Constant',
            cursor_blink_rate = 700,
            default_cursor_style = "SteadyBar",

            -- font
            -- font_size = 13.0,
            -- font = wezterm.font_with_fallback {
            --   { family = 'MonaspiceKr Nerd Font', weight = "Regular" },
            --   { family = 'CaskaydiaCove Nerd Font', weight = "Regular" },
            --   { family = "Symbols Nerd Font", weight = "Regular" },
            --   { family = 'Noto Color Emoji', weight = "Regular" },
            -- },
            font_antialias = 'Subpixel',
            line_height = 0.8,
            intensity = 'Normal',
            bold_brightens_ansi_colors = 'BrightOnly',
            freetype_interpreter_version = 35,

            keys = {
              -- paste from the clipboard
              { key = 'V', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'Clipboard' },

              -- paste from the primary selection
              { key = 'S', mods = 'SHIFT|CTRL', action = wezterm.action.PasteFrom 'PrimarySelection' },
            },

            -- Tab bar
            enable_tab_bar = true,
            hide_tab_bar_if_only_one_tab = true,
            show_tab_index_in_tab_bar = false,
            tab_bar_at_bottom = true,
            use_fancy_tab_bar = false,
            -- try and let the tabs stretch instead of squish
            tab_max_width = 10000,

            -- perf
            enable_wayland = true,
            front_end = "WebGpu",
            scrollback_lines = 10000,

            -- term window settings
            adjust_window_size_when_changing_font_size = false,
            inactive_pane_hsb = {
              saturation = 1.0,
              brightness = 0.8
            },
            -- window_background_opacity = 0.85,
            window_close_confirmation = "NeverPrompt",
            window_decorations = "RESIZE",
            window_padding = { left = 2, right = 2, top = 2, bottom = 2, },
          }
        '';
    };
  };
}
