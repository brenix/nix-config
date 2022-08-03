{ pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./mako.nix
    ./waybar.nix
    ./wofi.nix
  ];

  home.packages = with pkgs; [
    mimeo
    wf-recorder
    wl-clipboard
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
