{ inputs, pkgs, lib, config, ... }: {
  imports = [
    ../../home-manager
    ../../home-manager/programs
    ../../home-manager/security/sops.nix
  ];

  config = {
    modules = {
      editors = {
        helix.enable = true;
      };

      shells = {
        fish.enable = true;
      };

      terminals = {
        foot.enable = true;
      };
    };

    my.settings = {
      host = "iso";
      default = {
        shell = "${pkgs.fish}/bin/fish";
        terminal = "${pkgs.foot}/bin/foot";
        browser = "firefox";
        editor = "hx";
      };
      fonts.monospace = "FiraCode Nerd Font Mono";
    };

    colorscheme = inputs.nix-colors.colorSchemes.nord;

    home = {
      username = lib.mkDefault "nixos";
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
      stateVersion = lib.mkDefault "23.11";
    };
  };
}
