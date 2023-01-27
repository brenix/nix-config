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
    height = 25;
    font-0 = "${config.fontProfiles.regular.family}:size=8;3";
  };

  programs.alacritty.settings.font.size = 12;
  programs.alacritty.settings.font.normal.family = config.fontProfiles.monospace.family;
  programs.alacritty.settings.font.bold.family = config.fontProfiles.monospace.family;
  programs.alacritty.settings.font.italic.family = config.fontProfiles.monospace.family;

  programs.starship.settings.command_timeout = 1200;

  # colorscheme = inputs.nix-colors.colorSchemes.nord;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile (./colorschemes/nord-dark.yaml));
  wallpaper = pkgs.wallpapers.mountain-jaws;
}
