{ config, pkgs, ... }: {

  programs.rofi = {
    enable = true;
    font = "${config.fontProfiles.regular.family} 10";
    theme = "Arc";
    plugins = with pkgs; [ rofi-calc ];
  };

}
