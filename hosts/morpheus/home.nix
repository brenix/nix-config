{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ../../home-manager
    ../../home-manager/programs
    ../../home-manager/programs/development-tools.nix
    ../../home-manager/programs/kubernetes.nix
    ../../home-manager/programs/slack.nix
    ../../home-manager/programs/spotify.nix
    ../../home-manager/programs/sre-tools
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
        tmux.enable = true;
      };

      shells = {
        fish.enable = true;
      };

      wms = {
        bspwm.enable = true;
        hyprland.enable = true;
        notifications.dunst.enable = false;
        notifications.mako.enable = true;
        bars.polybar.enable = false;
        bars.waybar.enable = true;
        launchers.rofi.enable = false;
        launchers.wofi.enable = true;
        compositor.picom.enable = false;
      };

      terminals = {
        foot.enable = false;
        alacritty.enable = true;
      };
    };

    my.settings = {
      dpi = 123;
      wallpaper = "~/nix-config/home-manager/wallpapers/yosemite.png";
      host = "morpheus";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.alacritty}/bin/alacritty";
        browser = "firefox";
        editor = "hx";
      };
    };

    colorscheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;
    # colorscheme = inputs.nix-colors.lib-core.schemeFromYAML "zenbox" (builtins.readFile (../../home-manager/colorschemes/zenbox.yaml));

    home = {
      username = lib.mkDefault "brenix";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
    };

    # xsession.windowManager.bspwm.monitors = {
    #   eDP-1 = [ "1" "2" "3" "4" ];
    # };

    home.persistence = {
      "/persist/home/brenix" = {
        directories = [
          ".cache"
          "downloads"
          "work"
        ];
        allowOther = true;
      };
    };
  };
}
