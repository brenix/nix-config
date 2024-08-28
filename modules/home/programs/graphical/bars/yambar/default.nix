{
  config,
  lib,
  namespace,
  ...
}:
with config.stylix.fonts;
with config.lib.stylix.colors; let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.bars.yambar;
in {
  options.${namespace}.programs.graphical.bars.yambar = {
    enable = mkBoolOpt false "Enable yambar";
  };

  config = mkIf cfg.enable {
    programs.yambar = {
      enable = true;
      settings = {
        bar = {
          location = "top";
          height = 24;
          spacing = 5;
          margin = 5;
          background = "${base00}ff";
          font = "Berkeley Mono:pixelsize=14";

          # TODO
          # left = {};

          # TODO
          # center = {};

          right = [
            {
              pulse.content = [
                {
                  map.conditions = {
                    sink_muted.string = {
                      text = "󰖁";
                      foreground = "${base08}ff";
                      right-margin = 4;
                    };
                    "~sink_muted".string = {
                      text = "󰕾";
                      foreground = "${base0B}ff";
                      right-margin = 4;
                    };
                  };
                }
                {string.text = "{sink_percent}";}
              ];
            }
            {
              network = {
                poll-interval = 10000;
                content.map.conditions."name == enp7s0 || name == wlp1s0" = [
                  {
                    string = {
                      text = "";
                      right-margin = 4;
                    };
                  }
                  {
                    map = {
                      default.string.text = "{dl-speed:kib:.0}K";
                      conditions."dl-speed >= 1048576".string.text = "{dl-speed:mib:.1}M";
                    };
                  }
                  {
                    string = {
                      text = "";
                      left-margin = 6;
                      right-margin = 4;
                    };
                  }
                  {
                    map = {
                      default.string.text = "{ul-speed:kib:.0}K";
                      conditions."ul-speed >= 1048576".string.text = "{ul-speed:mib:.1}M";
                    };
                  }
                ];
              };
            }
            # {
            #   disk-io = {};
            # }
            {
              cpu = {
                poll-interval = 5000;
                content.map.conditions."id == -1" = [
                  {
                    string = {
                      text = "";
                      font = "${monospace.name}";
                      foreground = "${base0D}ff";
                    };
                  }
                  {
                    string = {
                      text = "  {cpu}%";
                    };
                  }
                ];
              };
            }
            {
              mem = {
                poll-interval = 15000;
                content = [
                  {
                    string = {
                      text = "";
                      font = "${monospace.name}";
                      foreground = "${base0B}ff";
                    };
                  }
                  {
                    string = {
                      text = "  {used:gb}GB";
                    };
                  }
                ];
              };
            }
            {
              clock = {
                content = [
                  {
                    string = {
                      text = "󰃭";
                      font = "${monospace.name}";
                      foreground = "${base0C}ff";
                    };
                  }
                  {
                    string = {
                      text = " {date}";
                    };
                  }
                ];
              };
            }
            {
              clock = {
                time-format = "%r %Z";
                content = [
                  {
                    string = {
                      text = "󰥔";
                      font = "${monospace.name}";
                      foreground = "${base09}ff";
                    };
                  }
                  {
                    string = {
                      text = " {time}";
                    };
                  }
                ];
              };
            }
          ];
        };
      };
    };
  };
}
