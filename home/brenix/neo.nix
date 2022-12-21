{ inputs, pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/bspwm
    ./features/golang
    ./features/kubernetes
  ];

  dpi = 108;

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      x = 0;
      workspace = "1";
      enabled = true;
    }
    {
      name = "HDMI-A-1";
      isSecondary = true;
      width = 2560;
      height = 1440;
      x = 2560;
      workspace = "2";
      enabled = true;
    }
  ];

  xsession.windowManager.bspwm.monitors = {
    HDMI-A-0 = [ "1" "2" ];
    DisplayPort-0 = [ "3" "4" ];
  };

  colorscheme = inputs.nix-colors.colorSchemes.nord;
  # colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
  wallpaper = pkgs.wallpapers.murky-peaks;
}
