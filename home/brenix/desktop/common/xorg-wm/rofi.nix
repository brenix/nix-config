{ config, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    font = "${config.fontProfiles.monospace.family} 9";
    theme = "Arc";
    plugins = with pkgs; [ rofi-calc rofi-emoji rofi-rbw ];
    extraConfig = {
      modi = "drun,run,emoji,calc,combi";
    };
    terminal = "\${pkgs.alacritty}/bin/alacritty";
  };

}
