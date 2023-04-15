{ inputs, ... }:
{
  imports = [
    ./cli/common
    ./cli/golang
    ./cli/gpg
    ./cli/kubernetes-tools
    ./cli/nvim
    ./cli/playerctl
    ./cli/terraform
    ./desktop/alacritty
    ./desktop/common
    ./desktop/dunst
    ./desktop/firefox
    ./desktop/flameshot
    ./desktop/openbox
    ./desktop/polybar
    ./desktop/rofi
    ./desktop/unclutter
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
  colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (./colorschemes/zenbox.yaml));
}
