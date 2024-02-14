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
    ../../home-manager/programs/zoom.nix
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
      dpi = 123;
      wallpaper = "~/nix-config/home-manager/wallpapers/wallhaven-85pej2.png";
      host = "morpheus";
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
      eDP-1 = [ "1" "2" "3" "4" ];
    };

    programs.alacritty.settings.font.normal.family = "tamzen";
    programs.alacritty.settings.font.bold.family = "tamzen";
    programs.alacritty.settings.font.italic.family = "tamzen";
    programs.alacritty.settings.font.size = 4;

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
