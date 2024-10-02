{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;

  cfg = config.${namespace}.programs.graphical.wms.labwc;
in {
  config = mkIf cfg.enable {
    xdg.configFile."labwc/menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>

      <openbox_menu>
      <menu id="root-menu">
        <item label="TERM">
          <action name="Execute" command="alacritty" />
        </item>
        <item label="BROWSER">
          <action name="Execute" command="firefox" />
        </item>
        <item label="DISCORD">
          <action name="Execute" command="discord" />
        </item>
        <item label="SPOTIFY">
          <action name="Execute" command="spotify" />
        </item>
        <separator />
        <item label="RELOAD">
          <action name="Reconfigure" />
        </item>
        <item label="EXIT">
          <action name="Exit" />
        </item>
        <item label="POWEROFF">
          <action name="Execute" command="systemctl -i poweroff" />
        </item>
      </menu>
      </openbox_menu>
    '';
  };
}
