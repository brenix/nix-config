{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with config.stylix.fonts;
with config.lib.stylix.colors; let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.bars.yambar;

  icon_font = "BerkeleyMono Nerd Font Mono:pixelsize=20";
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
          font = "BerkeleyMono Nerd Font Mono:pixelsize=14";
          left = [
            {
              script = {
                # TODO: switch back to official package. Alpha build was required to work
                path = "${pkgs.${namespace}.yambar-hyprland-wses}/bin/yambar-hyprland-wses";
                content = {
                  list = {
                    items = [
                      (let
                        ws_1 = "1";
                        ws_2 = "2";
                        ws_3 = "3";
                        ws_4 = "4";
                        ws_other = "${base05}ff";
                        ws_focused = "${base0A}ff";
                        ws_active = "${base05}ff";
                        ws_empty = "${base05}ff";
                      in [
                        # WORKSPACE 1
                        {
                          map = {
                            default.string = {
                              text = ws_1;
                              foreground = ws_other;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_1_focused.string = {
                              text = ws_1;
                              foreground = ws_focused;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_1_active.string = {
                              text = ws_1;
                              foreground = ws_active;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions."workspace_count < 2 || workspace_1_windows == 0".string = {
                              text = ws_1;
                              foreground = ws_empty;
                              # font = icon_font;
                              right-margin = 4;
                            };
                          };
                        }
                        # WORKSPACE 2
                        {
                          map = {
                            default.string = {
                              text = ws_2;
                              foreground = ws_other;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_2_focused.string = {
                              text = ws_2;
                              foreground = ws_focused;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_2_active.string = {
                              text = ws_2;
                              foreground = ws_active;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions."workspace_count < 3 || workspace_2_windows == 0".string = {
                              text = ws_2;
                              foreground = ws_empty;
                              # font = icon_font;
                              right-margin = 4;
                            };
                          };
                        }
                        # WORKSPACE 3
                        {
                          map = {
                            default.string = {
                              text = ws_3;
                              foreground = ws_other;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_3_focused.string = {
                              text = ws_3;
                              foreground = ws_focused;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions.workspace_3_active.string = {
                              text = ws_3;
                              foreground = ws_active;
                              # font = icon_font;
                              right-margin = 4;
                            };
                            conditions."workspace_count < 4 || workspace_3_windows == 0".string = {
                              text = ws_3;
                              foreground = ws_empty;
                              # font = icon_font;
                              right-margin = 4;
                            };
                          };
                        }
                        # WORKSPACE 4
                        {
                          map = {
                            default.string = {
                              text = ws_4;
                              foreground = ws_other;
                              # font = icon_font;
                            };
                            conditions.workspace_4_focused.string = {
                              text = ws_4;
                              foreground = ws_focused;
                              # font = icon_font;
                            };
                            conditions.workspace_4_active.string = {
                              text = ws_4;
                              foreground = ws_active;
                              # font = icon_font;
                            };
                            conditions."workspace_count < 5 || workspace_4_windows == 0".string = {
                              text = ws_4;
                              foreground = ws_empty;
                              # font = icon_font;
                            };
                          };
                        }
                      ])
                    ];
                  };
                };
              };
            }
          ];

          center = [
            {
              script = {
                path = "${pkgs.playerctl}/bin/playerctl";
                args = [
                  "--follow"
                  "metadata"
                  "-f"
                  ''
                    status|string|{{status}}
                    artist|string|{{artist}}
                    title|string|{{title}}
                  ''
                ];
                content = {
                  map = {
                    conditions."status == Paused".string.text = "";
                    conditions."status == Playing".list.items = [
                      {
                        string.text = " ";
                        string.font = icon_font;
                      }
                      {
                        string.text = "{artist} - {title}";
                      }
                    ];
                  };
                };
              };
            }
          ];

          right = [
            {
              cpu = {
                poll-interval = 5000;
                content.map.conditions."id == -1" = [
                  {
                    string = {
                      text = "";
                      font = icon_font;
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
                      font = icon_font;
                      foreground = "${base0A}ff";
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
              pulse.content = [
                {
                  map.conditions = {
                    sink_muted.string = {
                      text = "󰖁";
                      foreground = "${base08}ff";
                      right-margin = 4;
                      font = icon_font;
                    };
                    "~sink_muted".string = {
                      text = "󰕾";
                      foreground = "${base0B}ff";
                      right-margin = 4;
                      font = icon_font;
                    };
                  };
                }
                {string.text = "{sink_percent}";}
              ];
            }
            # {
            #   network = {
            #     poll-interval = 10000;
            #     content.map.conditions."name == enp7s0 || name == wlp1s0" = [
            #       {
            #         string = {
            #           text = "";
            #           right-margin = 4;
            #           font = icon_font;
            #         };
            #       }
            #       {
            #         map = {
            #           default.string.text = "{dl-speed:kib:.0}K";
            #           conditions."dl-speed >= 1048576".string.text = "{dl-speed:mib:.1}M";
            #         };
            #       }
            #       {
            #         string = {
            #           text = "";
            #           left-margin = 6;
            #           right-margin = 4;
            #           font = icon_font;
            #         };
            #       }
            #       {
            #         map = {
            #           default.string.text = "{ul-speed:kib:.0}K";
            #           conditions."ul-speed >= 1048576".string.text = "{ul-speed:mib:.1}M";
            #         };
            #       }
            #     ];
            #   };
            # }
            # {
            #   disk-io = {};
            # }
            {
              clock = {
                content = [
                  {
                    string = {
                      text = "󰃭";
                      font = icon_font;
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
                      font = icon_font;
                      foreground = "${base0E}ff";
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
