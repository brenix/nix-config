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
          height = 16;
          spacing = 5;
          # margin = 24;
          background = "${base00}ff";
          font = "Terminus:pixelsize=10";

          # TODO
          # left = {};

          # TODO
          # center = {};

          right = [
            # TODO
            # {
            #   pipewire = {};
            # }
            # {
            #   network = {};
            # }
            # {
            #   disk-io = {};
            # }
            {
              cpu = {
                poll-interval = 2500;
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
                      text = "  {cpu:02}%";
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
                      text = "  {used:mb}MB";
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
