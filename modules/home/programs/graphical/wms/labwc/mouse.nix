{
  programs.labwc.config.mouse = {
    scrollFactor = 0.5;
    default = false;
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
        {
          action = "Press";
          button = "Right";
          actions = [
            {
              name = "ShowMenu";
              menu = "root-menu";
            }
          ];
        }
        {
          action = "Scroll";
          direction = "Up";
          actions = [
            {
              name = "GoToDesktop";
              to = "left";
              wrap = "yes";
            }
          ];
        }
        {
          action = "Scroll";
          direction = "Down";
          actions = [
            {
              name = "GoToDesktop";
              to = "right";
              wrap = "yes";
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
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Move";
            }
          ];
        }
      ];

      "TitleBar" = [
        {
          action = "Press";
          button = "Left";
          actions = [
            {
              name = "Focus";
            }
            {
              name = "Raise";
            }
          ];
        }
        {
          action = "Press";
          button = "Right";
          actions = [
            {
              name = "None";
            }
          ];
        }
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

      "Top" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "Left" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "Right" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "Bottom" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "TRCorner" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "BRCorner" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "TLCorner" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "BLCorner" = [
        {
          action = "Drag";
          button = "Left";
          actions = [
            {
              name = "Resize";
            }
          ];
        }
      ];

      "Maximize" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "ToggleMaximize";
            }
          ];
        }
        {
          action = "Click";
          button = "Right";
          actions = [
            {
              name = "ToggleMaximize";
              direction = "horizontal";
            }
          ];
        }
        {
          action = "Click";
          button = "Middle";
          actions = [
            {
              name = "ToggleMaximize";
              direction = "vertical";
            }
          ];
        }
      ];

      "WindowMenu" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "ShowMenu";
              menu = "client-menu";
              atCursor = "no";
            }
          ];
        }
        {
          action = "Click";
          button = "Right";
          actions = [
            {
              name = "ShowMenu";
              menu = "client-menu";
              atCursor = "no";
            }
          ];
        }
      ];

      "Icon" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "ShowMenu";
              menu = "client-menu";
              atCursor = "no";
            }
          ];
        }
        {
          action = "Click";
          button = "Right";
          actions = [
            {
              name = "ShowMenu";
              menu = "client-menu";
              atCursor = "no";
            }
          ];
        }
      ];

      "Shade" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "ToggleShade";
            }
          ];
        }
      ];

      "AllDesktops" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "ToggleOmnipresent";
            }
          ];
        }
      ];

      "Iconify" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "Iconify";
            }
          ];
        }
      ];

      "Close" = [
        {
          action = "Click";
          button = "Left";
          actions = [
            {
              name = "Close";
            }
          ];
        }
      ];

      "Client" = [
        {
          action = "Press";
          button = "Left";
          actions = [
            {
              name = "Focus";
            }
            {
              name = "Raise";
            }
          ];
        }
        {
          action = "Press";
          button = "Middle";
          actions = [
            {
              name = "Focus";
            }
            {
              name = "Raise";
            }
          ];
        }
        {
          action = "Press";
          button = "Right";
          actions = [
            {
              name = "Focus";
            }
            {
              name = "Raise";
            }
          ];
        }
      ];
    };
  };
}
