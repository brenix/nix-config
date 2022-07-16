{ pkgs, ... }:
{
  imports = [
    ./mako.nix
    ./qutebrowser.nix
  ];

  home.packages = with pkgs; [
    mimeo
    slurp
    wf-recorder
    wl-clipboard
    wl-mirror
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
