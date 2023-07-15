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
      colors =
        {
          primary.background = "#ffffff";
          primary.foreground = "#000000";
          cursor.text = "#000000";
          cursor.cursor = "#000000";
          selection.text = "CellForeground";
          selection.background = "#ececec";
          footer_bar = {
            background = "#626262";
            foreground = "#000000";
          };
          search = {
            matches.foreground = "CellBackground";
            matches.background = "#ebcb8b";
          };
          normal = {
            black = "#080808";
            red = "#626262";
            green = "#868686";
            yellow = "#b2b2b2";
            blue = "#5e81ac";
            magenta = "#b48ead";
            cyan = "#555555";
            white = "#adadad";
          };
          bright = {
            black = "#464646";
            red = "#bf616a";
            green = "#333333";
            yellow = "#b2b2b2";
            blue = "#767676";
            magenta = "#b48ead";
            cyan = "#555555";
            white = "#ececec";
          };
        };

      # colors =
      #   {
      #     primary.background = "#${colors.base00}";
      #     primary.foreground = "#${colors.base05}";
      #     cursor.text = "#${colors.base00}";
      #     cursor.cursor = "#${colors.base04}";
      #     selection.text = "CellForeground";
      #     selection.background = "#${colors.base03}";
      #     footer_bar = {
      #       background = "#${colors.base03}";
      #       foreground = "#${colors.base04}";
      #     };
      #     search = {
      #       matches.foreground = "CellBackground";
      #       matches.background = "#${colors.base0C}";
      #     };
      #     normal = {
      #       black = "#${colors.base02}";
      #       red = "#${colors.base08}";
      #       green = "#${colors.base0B}";
      #       yellow = "#${colors.base0A}";
      #       blue = "#${colors.base0D}";
      #       magenta = "#${colors.base0E}";
      #       cyan = "#${colors.base0C}";
      #       white = "#${colors.base05}";
      #     };
      #     bright = {
      #       black = "#${colors.base03}";
      #       red = "#${colors.base08}";
      #       green = "#${colors.base0B}";
      #       yellow = "#${colors.base0A}";
      #       blue = "#${colors.base0D}";
      #       magenta = "#${colors.base0E}";
      #       cyan = "#${colors.base0C}";
      #       white = "#${colors.base06}";
      #     };
      #   };
    };
  };
}
