{ config, lib, ... }: {

  programs.alacritty = {
    enable = true;
    settings = {
      scrolling.history = 10000;
      scrolling.multiplier = 3;
      font.normal = {
        family = "Hack";
        style = "Regular";
      };
      font.bold = {
        family = "Hack";
        style = "Regular";
      };
      font.italic = {
        family = "Hack";
        style = "Italic";
      };
      font.size = lib.mkDefault 10;
      font.offset.y = -3;
      font.use_thin_strokes = false;
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
        let inherit (config.colorscheme) colors;
        in
        {
          primary.background = "#${colors.base00}";
          primary.foreground = "#${colors.base04}";
          cursor.text = "#${colors.base00}";
          cursor.cursor = "#${colors.base04}";
          selection.text = "CellForeground";
          selection.background = "#${colors.base03}";
          search = {
            matches.foreground = "CellBackground";
            matches.background = "#${colors.base0C}";
            bar.background = "#${colors.base03}";
            bar.foreground = "#${colors.base04}";
          };
          normal = {
            black = "#${colors.base02}";
            red = "#${colors.base08}";
            green = "#${colors.base0B}";
            yellow = "#${colors.base0A}";
            blue = "#${colors.base0D}";
            magenta = "#${colors.base0E}";
            cyan = "#${colors.base0C}";
            white = "#${colors.base05}";
          };
          bright = {
            black = "#${colors.base03}";
            red = "#${colors.base08}";
            green = "#${colors.base0B}";
            yellow = "#${colors.base0A}";
            blue = "#${colors.base0D}";
            magenta = "#${colors.base0E}";
            cyan = "#${colors.base0C}";
            white = "#${colors.base06}";
          };
        };
    };
  };
}
