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
      pavucontrol = {
        class = ["org.pulseaudio.pavucontrol"];
      };
      zoom = {
        class = ["zoom"];
      };
    in
      lib.concatLists [
        (map (rule ["float"]) [pavucontrol])
        (map (rule ["float"]) [zoom])
      ];
  };
}
