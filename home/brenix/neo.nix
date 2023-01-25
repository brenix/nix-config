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
    DisplayPort-0 = [ "1" "2" ];
    HDMI-A-0 = [ "3" "4" ];
  };

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile (./colorschemes/nord-dark.yaml));
  wallpaper = pkgs.wallpapers.mountain-jaws;
}
