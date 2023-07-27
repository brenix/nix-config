{ pkgs, ... }:
{
  imports = [
    ./foot
    ./mako
    ./waybar
    ./wofi
  ];

  home.packages = with pkgs; [
    mimeo
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
