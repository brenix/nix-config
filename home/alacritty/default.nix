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
      font.offset.y = -3;
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
      colors = {
        primary.background = "#161821";
        primary.foreground = "#d8dee9";
        dim_foreground = "#a5abb6";
        cursor.text = "#161821";
        cursor.cursor = "#d8dee9";
        selection.text = "CellForeground";
        selection.background = "#4c566a";
        search = {
          matches.foreground = "CellBackground";
          matches.background = "#88c0d0";
          bar.background = "#434c5e";
          bar.foreground = "#d8dee9";
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#eceff4";
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
