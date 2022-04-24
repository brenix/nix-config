{ config, ... }: {

  imports = [ ../../modules/settings.nix ];

  programs.alacritty = {
    enable = true;
    settings = {
      dpi = {
        x = config.settings.dpi;
        y = config.settings.dpi;
      };
      scrolling.history = 10000;
      scrolling.multiplier = 3;
      font.normal.family = config.settings.fonts.terminal.font;
      font.normal.style = "Regular";
      font.bold.family = config.settings.fonts.terminal.font;
      font.bold.style = "Regular";
      font.italic.family = config.settings.fonts.terminal.font;
      font.italic.style = "Italic";
      font.size = config.settings.fonts.terminal.size;
      font.offset.y = -2;
      font.use_thin_strokes = false;
      draw_bold_text_with_bright_colors = false;
      mouse_bindings = [{
        mouse = "Right";
        action = "PasteSelection";
      }];
      selection.save_to_clipboard = true;
      window.padding.x = 0;
      window.padding.y = 0;
      window.dimensions.columns = 140;
      window.dimensions.lines = 50;
      decorations = "none";
      colors =
        let inherit (config.colorscheme) colors;
        in
        {
          primary.background = "#${colors.base00}";
          primary.foreground = "#${colors.base04}";
          dim_foreground = "##aeb3bb";
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
          dim = {
            black = "#373e4d";
            red = "#94545d";
            green = "#809575";
            yellow = "#b29e75";
            blue = "#68809a";
            magenta = "#8c738c";
            cyan = "#6d96a5";
            white = "#aeb3bb";
          };
          indexed_colors = [
            {
              index = 16;
              color = "#d18616";
            }
            {
              index = 17;
              color = "#cd3131";
            }
          ];
        };
    };
  };
}
