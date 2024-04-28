{
  roles = {
    desktop.enable = true;
  };

  desktops.hyprland.enable = true;
  desktops.hyprland.swapCapsEsc = true;

  matrix.user = {
    enable = true;
    name = "brenix";
  };

  programs.foot.settings.main = {
    font = "Monaco Nerd Font Mono:size=14, Noto Color Emoji:size=20";
    font-bold = "Monaco Nerd Font Mono:size=14:weight=Regular";
    line-height = "20px";
  };

  home.stateVersion = "23.11";
}
