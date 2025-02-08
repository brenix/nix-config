{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.ncmpcpp;
in {
  options.${namespace}.programs.terminal.tools.ncmpcpp = {
    enable = mkBoolOpt false "Whether or not install ncmpcpp";
  };

  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      settings = {
        song_list_format = "{{%a - %t}|{%f}}{$R%l}";
        song_status_format = "{{%a{ $2//$9 %b{, %y}} $2//$9 }{%t$/b}}|{$b%f$/b}";
        song_library_format = "{{%a - %t} (%b)}|{%f}";
      };
      bindings = [
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "k";
          command = "scroll_up";
        }
        {
          key = "J";
          command = ["select_item" "scroll_down"];
        }
        {
          key = "K";
          command = ["select_item" "scroll_up"];
        }
        {
          key = "h";
          command = ["previous_column"];
        }
        {
          key = "l";
          command = ["next_column"];
        }
      ];
    };
  };
}
