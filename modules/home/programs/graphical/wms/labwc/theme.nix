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
    xdg.configFile."labwc/themerc-override".text = ''
      # general
      border.width: 1
      padding.width: 0
      padding.height: 0

      # The following options has no default, but fallbacks back to
      # font-height + 2x padding.height if not set.
      titlebar.height: 10

      # window border
      window.active.border.color: #464649
      window.inactive.border.color: #27272a

      # ToggleKeybinds status indicator
      window.active.indicator.toggled-keybind.color: #ff0000

      # window titlebar background
      window.active.title.bg.color: #27272a
      window.inactive.title.bg.color: #161617

      # window titlebar text
      window.active.label.text.color: #c9c7cd
      window.inactive.label.text.color: #353539
      window.label.text.justify: center

      # window button width and spacing
      window.button.width: 15
      window.button.spacing: 0

      # window button hover effect
      window.button.hover.bg.shape: rectangle

      # window buttons
      window.active.button.unpressed.image.color: #909095
      window.inactive.button.unpressed.image.color: #909095

      # window drop-shadows
      window.active.shadow.size: 60
      window.inactive.shadow.size: 40
      window.active.shadow.color: #00000060
      window.inactive.shadow.color: #00000040

      # Note that "menu", "iconify", "max", "close" buttons colors can be defined
      # individually by inserting the type after the button node, for example:
      #
      #     window.active.button.iconify.unpressed.image.color: #333333

      # menu
      menu.overlap.x: 0
      menu.overlap.y: 0
      menu.width.min: 50
      menu.width.max: 200
      menu.items.bg.color: #161617
      menu.items.text.color: #c9c7cd
      menu.items.active.bg.color: #e1dedb
      menu.items.active.text.color: #000000
      menu.items.padding.x: 6
      menu.items.padding.y: 1
      menu.separator.width: 1
      menu.separator.padding.width: 6
      menu.separator.padding.height: 1
      menu.separator.color: #909095
      menu.title.bg.color: #161617
      menu.title.text.color: #ffffff
      menu.title.text.justify: Center

      # on screen display (window-cycle dialog)
      osd.bg.color: #e1dedb
      osd.border.color: #000000
      osd.border.width: 1
      osd.label.text.color: #000000

      # width can be set as percent (of screen width)
      # example 50% or 75% instead of 600, max 100%
      osd.window-switcher.width: 600

      osd.window-switcher.padding: 4
      osd.window-switcher.item.padding.x: 10
      osd.window-switcher.item.padding.y: 1
      osd.window-switcher.item.active.border.width: 2
      osd.window-switcher.preview.border.width: 1
      osd.window-switcher.preview.border.color: #dddda6,#000000,#dddda6

      osd.workspace-switcher.boxes.width: 10
      osd.workspace-switcher.boxes.height: 10

      # Default values for following options change depending on the rendering
      # backend. For software-based renderers, *.bg.enabled is "no" and
      # *.border.enabled is "yes" if not set. For hardware-based renderers,
      # *.bg.enabled is "yes" and *.border.enabled is "no" if not set.
      # Setting *.bg.enabled to "yes" for software-based renderer with translucent
      # background color may severely impact performance.
      #
      # snapping.overlay.region.bg.enabled:
      # snapping.overlay.edge.bg.enabled:
      # snapping.overlay.region.border.enabled:
      # snapping.overlay.edge.border.enabled:

      snapping.overlay.region.bg.color: #8080b380
      snapping.overlay.edge.bg.color: #8080b380
      snapping.overlay.region.border.width: 1
      snapping.overlay.edge.border.width: 1
      snapping.overlay.region.border.color: #dddda6,#000000,#dddda6
      snapping.overlay.edge.border.color: #dddda6,#000000,#dddda6
    '';
  };
}
