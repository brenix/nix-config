{ config, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    font = "${config.fontProfiles.monospace.family} 12";
    theme = "catppuccin-mocha";
    plugins = with pkgs; [ rofi-calc rofi-emoji rofi-rbw ];
    extraConfig = {
      modi = "drun,run,emoji,calc,combi";
      dpi = config.dpi;
    };
    terminal = "\${pkgs.alacritty}/bin/alacritty";
  };

  home.file.".config/rofi/nord.rasi" = {
    source = ./nord.rasi;
  };

  home.file.".config/rofi/catppuccin-mocha.rasi" = {
    source = ./catppuccin-mocha.rasi;
  };

}
