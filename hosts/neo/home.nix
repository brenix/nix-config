{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ../../home-manager
    ../../home-manager/programs
    ../../home-manager/programs/containers.nix
    ../../home-manager/programs/development-tools.nix
    ../../home-manager/programs/discord.nix
    ../../home-manager/programs/kubernetes.nix
    ../../home-manager/programs/slack.nix
    ../../home-manager/programs/spotify.nix
    ../../home-manager/programs/sre-tools
    ../../home-manager/programs/wootility.nix
  ];

  config = {
    modules = {
      browsers = {
        firefox.enable = true;
        chromium.enable = false;
      };

      editors = {
        helix.enable = true;
        vscode.enable = false;
      };

      multiplexers = {
        tmux.enable = true;
      };

      shells = {
        fish.enable = true;
      };

      wms = {
        bspwm.enable = false;
        hyprland.enable = true;
        notifications.dunst.enable = false;
        notifications.mako.enable = true;
        bars.polybar.enable = false;
        bars.waybar.enable = true;
        launchers.rofi.enable = true;
        compositor.picom.enable = false;
      };

      terminals = {
        alacritty.enable = true;
        foot.enable = false;
      };
    };

    my.settings = {
      dpi = 108;
      wallpaper = "~/nix-config/home-manager/wallpapers/yosemite.png";
      host = "neo";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        browser = "firefox";
        editor = "hx";
      };
    };

    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
    # colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "nord-dark" (builtins.readFile (../../home-manager/colorschemes/nord-dark.yaml));

    home = {
      username = lib.mkDefault "brenix";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
    };

    # xsession.windowManager.bspwm.monitors = {
    #   DP-1 = [ "1" "2" ];
    #   HDMI-1 = [ "3" "4" ];
    # };
  };
}
