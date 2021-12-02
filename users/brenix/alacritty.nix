{ config, ... }: {
  imports = [
    ../../modules/settings.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      env.term = "xterm-256color";
      scrolling.history = 10000;
      scrolling.multiplier = 3;
      font.normal.family = config.settings.fontName;
      font.normal.style = "Regular";
      font.bold.family = config.settings.fontName;
      font.bold.style = "Regular";
      font.italic.family = config.settings.fontName;
      font.italic.style = "Italic";
      font.size = config.settings.fontSize;
      font.offset.y = -3;
      font.use_thin_strokes = false;
      draw_bold_text_with_bright_colors = false;
      mouse_bindings = [
        {
          mouse = "Right";
          action = "PasteSelection";
        }
      ];
      selection.save_to_clipboard = true;
      window.padding.x = 0;
      window.padding.y = 0;
      window.dimensions.columns = 140;
      window.dimensions.lines = 50;
      decorations = "none";
      colors = {
        primary.background = "#ffffff";
        primary.foreground = "#1b1f23";
        normal = {
          black = "#24292e";
          red = "#cb2431";
          green = "#22863a";
          yellow = "#a04100";
          blue = "#005cc5";
          magenta = "#4c2889";
          cyan = "#0a3069";
          white = "#959da5";
        };
        bright = {
          black = "#959da5";
          red = "#d73a49";
          green = "#28a745";
          yellow = "#c24e00";
          blue = "#0366d6";
          magenta = "#6f42c1";
          cyan = "#0a3069";
          white = "#d1d5da";
        };
        indexed_colors = [
          { index = 16; color = "#d18616"; }
          { index = 17; color = "#cd3131"; }
        ];
      };
    };
  };
}
