{ config, lib, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling.history = 10000;
      scrolling.multiplier = 3;
      font.normal = {
        family = config.fontProfiles.monospace.family;
        # family = "Terminus";
        style = "Regular";
      };
      font.bold = {
        family = config.fontProfiles.monospace.family;
        # family = "Terminus";
        style = "Regular";
      };
      font.italic = {
        family = config.fontProfiles.monospace.family;
        # family = "Terminus";
        style = "Italic";
      };
      font.size = lib.mkDefault 10;
      font.offset.y = -3;
      draw_bold_text_with_bright_colors = false;
      mouse_bindings = [{
        mouse = "Right";
        action = "PasteSelection";
      }];
      selection.save_to_clipboard = true;
      window.padding.x = 8;
      window.padding.y = 6;
      window.dimensions.columns = 140;
      window.dimensions.lines = 50;
      decorations = "none";
      dynamic_padding = false;

      colors = {
        primary = { background = "0xffffff"; foreground = "0x1b1f24"; };
        cursor = { text = "0xffffff"; cursor = "0x24292f"; };
        normal = { black = "0x24292f"; red = "0xcf222e"; green = "0x0550ae"; yellow = "0x4d2d00"; blue = "0x0969da"; magenta = "0x8250df"; cyan = "0x1b7c83"; white = "0x6e7781"; };
        bright = { black = "0x57606a"; red = "0xa40e26"; green = "0x0969da"; yellow = "0x633c01"; blue = "0x218bff"; magenta = "0x8250df"; cyan = "0x1b7c83"; white = "0x6e7781"; };
      };

      # colors = {
      #   primary.background = "#${colors.base00}";
      #   primary.foreground = "#${colors.base05}";
      #   cursor.text = "#${colors.base00}";
      #   cursor.cursor = "#${colors.base04}";
      #   selection.text = "CellForeground";
      #   selection.background = "#${colors.base03}";
      #   footer_bar = {
      #     background = "#${colors.base03}";
      #     foreground = "#${colors.base04}";
      #   };
      #   search = {
      #     matches.foreground = "CellBackground";
      #     matches.background = "#${colors.base0C}";
      #   };
      #   normal = {
      #     black = "#${colors.base02}";
      #     red = "#${colors.base08}";
      #     green = "#${colors.base0B}";
      #     yellow = "#${colors.base0A}";
      #     blue = "#${colors.base0D}";
      #     magenta = "#${colors.base0E}";
      #     cyan = "#${colors.base0C}";
      #     white = "#${colors.base05}";
      #   };
      #   bright = {
      #     black = "#${colors.base03}";
      #     red = "#${colors.base08}";
      #     green = "#${colors.base0B}";
      #     yellow = "#${colors.base0A}";
      #     blue = "#${colors.base0D}";
      #     magenta = "#${colors.base0E}";
      #     cyan = "#${colors.base0C}";
      #     white = "#${colors.base06}";
      #   };
      # };


    };
  };
}
