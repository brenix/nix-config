{ config, pkgs, lib, ... }:

with lib;

{
  options = {
    settings = {
      name = mkOption {
        default = "Paul Nicholson";
        type = with types; uniq str;
      };
      username = mkOption {
        default = "brenix";
        type = with types; uniq str;
      };
      email = mkOption {
        default = "brenix@gmail.com";
        type = with types; uniq str;
      };
      vm = mkOption {
        type = types.bool;
        default = false;
      };
      browser = mkOption {
        default = "firefox;"
        type = with types; uniq str;
      }
      terminal = mkOption {
        default = "alacritty";
        type = with types; uniq str;
      };
      fontName = mkOption {
        default = "JetBrainsMono Nerd Font";
        type = with types; uniq str;
      };
      fontSize = mkOption {
        default = 12.0;
        type = types.float;
      };
      profile = mkOption {
        default = "brenix";
        type = with types; uniq str;
        description = ''
          Profiles are a higher-level grouping than hosts. They are
          useful to combine multiple related things (e.g. ssh keys)
          that should be available on multiple hosts.
        '';
      };
    };
  };
}
