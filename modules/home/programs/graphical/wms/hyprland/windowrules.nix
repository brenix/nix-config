{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  rule = rules: attrs: attrs // {inherit rules;};
  cfg = config.${namespace}.programs.graphical.wms.hyprland;
in {
  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.windowRules = let
      firefoxVideo = {
        class = ["firefox"];
      };
      guildWars = {
        title = ["Guild Wars 2"];
      };
      bitwarden = {
        title = [".*Bitwarden.*"];
      };
      pavucontrol = {
        class = ["pavucontrol"];
      };
      zoom = {
        class = ["zoom"];
      };
    in
      lib.concatLists [
        (map (rule ["idleinhibit fullscreen"]) [firefoxVideo])
        (map (rule ["fullscreen"]) [guildWars])
        (map (rule ["float"]) [bitwarden])
        (map (rule ["float"]) [pavucontrol])
        (map (rule ["float"]) [zoom])
      ];
  };
}
