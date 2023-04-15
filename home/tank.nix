{ config, inputs, pkgs, ... }:
{
  imports = [
    ./cli/common
    ./cli/golang
    ./cli/gpg
    ./cli/kubernetes-tools
    ./cli/nvim
    ./cli/terraform
    ./desktop/alacritty
    ./desktop/common
    ./desktop/dunst
    ./desktop/firefox
    ./desktop/rofi
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

  programs.alacritty.settings.font.size = 16;

  programs.starship.settings.command_timeout = 1200;

  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
}
