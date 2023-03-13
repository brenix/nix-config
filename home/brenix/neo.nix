{ inputs, pkgs, ... }:
{
  imports = [
    ./global
    # ./features/barrier
    ./features/desktop/openbox
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

  # colorscheme = inputs.nix-colors.colorSchemes.grayscale-dark;
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile (./colorschemes/nord-dark.yaml));
  wallpaper = pkgs.wallpapers.mountain-jaws;
}
