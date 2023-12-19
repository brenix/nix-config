{ inputs, ... }:
{
  imports = [
    ./common/global
    ./common/optional/bspwm.nix
    ./common/optional/desktop
    ./common/optional/development.nix
    ./common/optional/firefox.nix
    ./common/optional/gpg.nix
    ./common/optional/kubernetes-tools.nix
    ./common/optional/music.nix
    ./common/optional/slack.nix
    ./common/optional/sre-tools
    ./common/optional/sxhkd.nix
    ./common/optional/todoist.nix
    ./common/optional/xorg-common
    ./common/optional/zoom.nix
  ];

  dpi = 208;

  monitors = [
    {
      name = "eDP-1";
      width = 2256;
      height = 1504;
      refreshRate = 60;
      x = 0;
      workspace = "1";
      enabled = true;
    }
  ];

  xsession.windowManager.bspwm.monitors = {
    eDP-1 = [ "1" "2" "3" "4" ];
  };

  colorscheme = inputs.nix-colors.colorSchemes.github;
  # colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
}
