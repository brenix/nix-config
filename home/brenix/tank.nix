{ inputs, pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/bspwm
  ];

  dpi = 220;

  monitors = [
    {
      name = "Virtual-1";
      width = 2880;
      height = 1800;
      x = 0;
      workspace = "1";
      enabled = true;
    }
  ];

  xsession.windowManager.bspwm.monitors = {
    Virtual-1 = [ "1" "2" "3" "4" "5" ];
  };

  /* colorscheme = inputs.nix-colors.colorSchemes.catppuccin; */
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "catppuccin-mocha" (builtins.readFile (./colorschemes/catppuccin-mocha.yaml));

  wallpaper = pkgs.wallpapers.mountain-1;
}
