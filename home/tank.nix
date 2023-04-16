{ config, inputs, ... }:
{
  imports = [
    ./common/global
    ./common/optional/desktop
    ./common/optional/development.nix
    ./common/optional/firefox.nix
    ./common/optional/gpg.nix
    ./common/optional/kubernetes-tools.nix
    ./common/optional/openbox.nix
    ./common/optional/slack.nix
    ./common/optional/sre-tools
    ./common/optional/xorg-common
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
