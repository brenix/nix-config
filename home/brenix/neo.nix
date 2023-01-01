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
      name = "DP-4";
      width = 2560;
      height = 1440;
      x = 0;
      workspace = "1";
      enabled = true;
    }
    {
      name = "DP-2";
      isSecondary = true;
      width = 2560;
      height = 1440;
      x = 2560;
      workspace = "2";
      enabled = true;
    }
  ];

  xsession.windowManager.bspwm.monitors = {
    DP-4 = [ "1" "2" ];
    DP-2 = [ "3" "4" ];
  };

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "simple" (builtins.readFile (./colorschemes/simple.yaml));
  wallpaper = pkgs.wallpapers.nixos-dark;
}
