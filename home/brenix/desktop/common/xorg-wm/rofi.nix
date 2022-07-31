{ config, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    font = "${config.fontProfiles.monospace.family} 9";
    theme = "Arc";
    plugins = with pkgs; [ rofi-calc ];
  };

}
