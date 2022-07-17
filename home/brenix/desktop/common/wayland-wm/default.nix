{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./qutebrowser.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    mimeo
    slurp
    wf-recorder
    wl-clipboard
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
