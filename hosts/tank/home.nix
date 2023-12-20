{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ../../home-manager
    ../../home-manager/programs
  ];

  config = {
    modules = {
      browsers = {
        firefox.enable = true;
      };

      editors = {
        helix.enable = true;
      };

      multiplexers = {
        tmux.enable = false;
      };

      shells = {
        fish.enable = true;
      };

      wms = {
        bspwm.enable = true;
        notifications.dunst.enable = true;
        bars.polybar.enable = true;
        launchers.rofi.enable = true;
        compositor.picom.enable = false;
      };

      terminals = {
        alacritty.enable = true;
      };
    };

    my.settings = {
      wallpaper = "~/nix-config/home-manager/wallpapers/stone.jpg";
      host = "tank";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        browser = "firefox";
        editor = "hx";
      };
    };

    # colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
    colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (../../home-manager/colorschemes/zenbox.yaml));

    home = {
      username = lib.mkDefault "brenix";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
    };

    xsession.windowManager.bspwm.monitors = {
      Virtual-1 = [ "1" "2" "3" "4" ];
    };
  };
}
