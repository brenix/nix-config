{
  matrix = {
    user = {
      enable = true;
      name = "brenix";
    };

    roles = {
      desktop.enable = true;
    };

    programs.graphical.wms.labwc = {
      enable = true;
      swapCapsEsc = true;
    };
  };

  home.stateVersion = "23.11";
}
