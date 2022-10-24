{ config, pkgs, dpi, ... }: {

  programs.rofi = {
    enable = true;
    font = "${config.fontProfiles.monospace.family} 10";
    theme = "catppuccin-mocha";
    plugins = with pkgs; [ rofi-calc rofi-emoji rofi-rbw ];
    extraConfig = {
      modi = "drun,run,emoji,calc,combi";
      inherit dpi;
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
