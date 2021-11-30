{ config, ...}: {
  imports = [
    ../../modules/settings.nix
  ];

  programs.alacritty = {
    enable = true;
    settings = {
      dpi = { x = config.settings.dpi; y = config.settings.dpi; };
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
      decorations = "none";
    };
  };
}
