{ config, inputs, pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/bspwm
    ./features/golang
    ./features/kubernetes
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

  services.polybar.settings."bar/main" = {
    height = 45;
    font-0 = "${config.fontProfiles.regular.family}:size=10;3";
    font-1 = "Material Icons:size=9;4";
    font-2 = "Font Awesome 6 Free Solid:size=9;3";
  };

  programs.alacritty.settings.font.size = 14;

  programs.starship.settings.command_timeout = 1200;

  /* colorscheme = inputs.nix-colors.colorSchemes.catppuccin; */
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "catppuccin-mocha" (builtins.readFile (./colorschemes/catppuccin-mocha.yaml));
  wallpaper = pkgs.wallpapers.evening-sky;

}
