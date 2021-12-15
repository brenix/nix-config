{ lib, ... }:

with lib; {
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
      browser = mkOption {
        default = "firefox";
        type = with types; uniq str;
      };
      terminal = mkOption {
        default = "alacritty";
        type = with types; uniq str;
      };
      monitor = mkOption {
        default = "Virtual-1";
        type = with types; uniq str;
      };
      dpi = mkOption {
        default = 96;
        type = types.int;
      };
      fonts = mkOption {
        default = {
          browser = {
            font = "Verdana";
            size = 16;
          };
          launcher = {
            font = "Verdana";
            size = 10;
          };
          terminal = {
            font = "JetBrains Mono Nerd Font";
            size = 12;
          };
        };
      };
    };
  };
}
