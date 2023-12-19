{ inputs, ... }:
{
  imports = [
    ./common/global
    ./common/optional/bspwm.nix
    ./common/optional/desktop
    ./common/optional/development.nix
    ./common/optional/discord.nix
    ./common/optional/epr.nix
    ./common/optional/firefox.nix
    ./common/optional/gpg.nix
    ./common/optional/kubernetes-tools.nix
    ./common/optional/music.nix
    ./common/optional/slack.nix
    ./common/optional/sre-tools
    ./common/optional/sxhkd.nix
    ./common/optional/todoist.nix
    ./common/optional/wootility.nix
    ./common/optional/xorg-common
    ./common/optional/zoom.nix
  ];

  dpi = 108;

  monitors = [
    {
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 165;
      x = 0;
      workspace = "1";
      enabled = true;
    }
    {
      name = "HDMI-1";
      isSecondary = true;
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 2560;
      workspace = "2";
      enabled = true;
    }
  ];

  xsession.windowManager.bspwm.monitors = {
    DP-1 = [ "1" "2" ];
    HDMI-1 = [ "3" "4" ];
  };

  xdg.configFile."barrier/barrier.conf" = {
    enable = true;
    text = ''
      section: screens
        neo:
          halfDuplexCapsLock = false
          halfDuplexNumLock = false
          halfDuplexScrollLock = false
        windows:
          halfDuplexCapsLock = false
          halfDuplexNumLock = false
          halfDuplexScrollLock = false
      end

      section: links
        neo:
          right = windows
        windows:
          left = neo
      end

      section: options
        relativeMouseMoves = true
      end
    '';
  };

  # colorscheme = inputs.nix-colors.colorSchemes.github;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
}
