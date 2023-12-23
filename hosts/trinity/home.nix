{ inputs, pkgs, lib, config, ... }:
{
  imports = [
    ../../home-manager
  ];

  config = {
    modules = {
      browsers = {
        firefox.enable = false;
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
        bspwm.enable = false;
      };

      terminals = {
        alacritty.enable = false;
      };
    };

    my.settings = {
      host = "trinity";
      headless = true;
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.alacritty}/bin/alacritty";
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
  };
}
