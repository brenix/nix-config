{
  matrix = {
    user = {
      enable = true;
      name = "brenix";
    };

    roles = {
      desktop.enable = true;
    };

    programs.graphical.wms.labwc.enable = true;
    programs.graphical.wms.labwc.swapCapsEsc = true;
    programs.labwc.config.mouse.scrollFactor = 0.5;
  };

  home.stateVersion = "23.11";
}
