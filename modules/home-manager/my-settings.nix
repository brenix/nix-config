{ lib, pkgs, ... }:
let
  inherit (lib) types mkOption;
in
{
  options.my.settings = {

    default = {
      shell = mkOption {
        type = types.nullOr (types.enum [ "${pkgs.fish}/bin/fish" "${pkgs.zsh}/bin/zsh" ]);
        description = "The default shell to use";
        default = "${pkgs.fish}/bin/fish";
      };

      terminal = mkOption {
        type = types.nullOr (types.enum [ "${pkgs.alacritty}/bin/alacritty" "${pkgs.foot}/bin/foot" ]);
        description = "The default terminal to use";
        default = "${pkgs.foot}/bin/foot";
      };

      browser = mkOption {
        type = types.nullOr (types.enum [ "firefox" "chromium" ]);
        description = "The default browser to use";
        default = "firefox";
      };

      editor = mkOption {
        type = types.nullOr (types.enum [ "hx" "nvim" ]);
        description = "The default editor to use";
        default = "hx";
      };
    };

    dpi = mkOption {
      type = types.int;
      default = 96;
    };

    headless = mkOption {
      type = types.bool;
      default = false;
    };

    wallpaper = mkOption {
      type = types.str;
      default = "";
      description = ''
        Wallpaper path
      '';
    };

    fonts = {
      regular = mkOption {
        type = types.str;
        description = "The font for regular text";
        default = "Inter";
      };

      monospace = mkOption {
        type = types.str;
        description = "The font for monospace text";
        default = "Monaco Nerd Font Mono";
      };
    };

    host = mkOption {
      type = types.str;
      default = "";
      description = ''
        Name of the host
      '';
    };
  };
}
