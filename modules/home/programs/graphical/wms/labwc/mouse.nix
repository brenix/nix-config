{
  programs.labwc.config.mouse = {
    default = true;
    mousebinds = {
      "Root" = [
        {
          action = "Press";
          button = "Left";
          actions = [
            {
              name = "None";
            }
          ];
        }
      ];

      "Frame" = [
        {
          action = "Drag";
          button = "W-Left";
          actions = [
            {
              name = "Move";
            }
          ];
        }
        {
          action = "Drag";
          button = "W-Right";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "Title" = [
        # Disable context menu on right-click
        {
          action = "Click";
          button = "Right";
          actions = [
            {
              name = "None";
            }
          ];
        }
      ];

      "TitleBar" = [
        {
          action = "Press";
          button = "Right";
          actions = [
            {
              name = "ToggleShade";
            }
          ];
        }
        {
          action = "Scroll";
          direction = "Up";
          actions = [
            {
              name = "Unshade";
            }
          ];
        }
        {
          action = "Scroll";
          direction = "Down";
          actions = [
            {
              name = "Shade";
            }
          ];
        }
      ];
    };
  };
}
