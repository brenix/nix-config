{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.wms.openbox;
  colors = config.colorscheme.palette;
in
{
  options.modules.wms.openbox = {
    enable = mkEnableOption "enable openbox window manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      openbox
    ];

    xdg.configFile."openbox/autostart".text = ''
      "${pkgs.feh}/bin/feh --bg-scale ${config.my.settings.wallpaper}"
      "${pkgs.flameshot}/bin/flameshot"
    '';

    xdg.configFile."openbox/rc.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <openbox_config xmlns="http://openbox.org/3.4/rc" xmlns:xi="http://www.w3.org/2001/XInclude">
        <resistance>
          <strength>10</strength>
          <screen_edge_strength>20</screen_edge_strength>
        </resistance>
        <focus>
          <focusNew>yes</focusNew>
          <followMouse>yes</followMouse>
          <focusLast>yes</focusLast>
          <underMouse>no</underMouse>
          <focusDelay>50</focusDelay>
          <raiseOnFocus>no</raiseOnFocus>
        </focus>
        <placement>
          <policy>Smart</policy>
          <center>yes</center>
          <monitor>Mouse</monitor>
          <primaryMonitor>1</primaryMonitor>
        </placement>
        <theme>
          <name>nix-openbox</name>
          <titleLayout>LMC</titleLayout>
          <!--
            available characters are NDSLIMC, each can occur at most once.
            N: window icon
            L: window label (AKA title).
            I: iconify
            M: maximize
            C: close
            S: shade (roll up/down)
            D: omnipresent (on all desktops).
          -->
          <keepBorder>no</keepBorder>
          <animateIconify>yes</animateIconify>
          <font place="ActiveWindow">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
          <font place="InactiveWindow">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
          <font place="MenuHeader">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
          <font place="MenuItem">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
          <font place="ActiveOnScreenDisplay">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
          <font place="InactiveOnScreenDisplay">
            <name>Terminus</name>
            <size>8</size>
            <weight>Normal</weight>
            <slant>Normal</slant>
          </font>
        </theme>
        <desktops>
          <number>4</number>
          <firstdesk>1</firstdesk>
          <names>
            <name>1</name>
            <name>2</name>
            <name>3</name>
            <name>4</name>
          </names>
          <popupTime>200</popupTime>
          <!-- The number of milliseconds to show the popup for when switching
              desktops.  Set this to 0 to disable the popup. -->
        </desktops>
        <resize>
          <drawContents>yes</drawContents>
          <popupShow>Nonpixel</popupShow>
          <!-- 'Always', 'Never', or 'Nonpixel' (xterms and such) -->
          <popupPosition>Center</popupPosition>
          <!-- 'Center', 'Top', or 'Fixed' -->
          <popupFixedPosition>
            <!-- these are used if popupPosition is set to 'Fixed' -->
            <x>10</x>
            <!-- positive number for distance from left edge, negative number for
                distance from right edge, or 'Center' -->
            <y>10</y>
            <!-- positive number for distance from top edge, negative number for
                distance from bottom edge, or 'Center' -->
          </popupFixedPosition>
        </resize>
        <!-- You can reserve a portion of your screen where windows will not cover when
            they are maximized, or when they are initially placed.
            Many programs reserve space automatically, but you can use this in other
            cases. -->
        <margins>
          <top>0</top>
          <bottom>0</bottom>
          <left>0</left>
          <right>0</right>
        </margins>
        <dock>
          <position>TopLeft</position>
          <!-- (Top|Bottom)(Left|Right|)|Top|Bottom|Left|Right|Floating -->
          <floatingX>0</floatingX>
          <floatingY>0</floatingY>
          <noStrut>no</noStrut>
          <stacking>Above</stacking>
          <!-- 'Above', 'Normal', or 'Below' -->
          <direction>Vertical</direction>
          <!-- 'Vertical' or 'Horizontal' -->
          <autoHide>no</autoHide>
          <hideDelay>300</hideDelay>
          <!-- in milliseconds (1000 = 1 second) -->
          <showDelay>300</showDelay>
          <!-- in milliseconds (1000 = 1 second) -->
          <moveButton>Middle</moveButton>
          <!-- 'Left', 'Middle', 'Right' -->
        </dock>
        <keyboard>
          <chainQuitKey>C-g</chainQuitKey>
          <!-- Keybindings for desktop switching -->
          <keybind key="A-Shift-space">
            <action name="ShowMenu">
              <menu>root-menu</menu>
            </action>
          </keybind>
          <keybind key="W-Left">
            <action name="GoToDesktop">
              <to>left</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="W-Right">
            <action name="GoToDesktop">
              <to>right</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="W-Up">
            <action name="GoToDesktop">
              <to>up</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="W-Down">
            <action name="GoToDesktop">
              <to>down</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="S-W-Left">
            <action name="SendToDesktop">
              <to>left</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="S-W-Right">
            <action name="SendToDesktop">
              <to>right</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="S-W-Up">
            <action name="SendToDesktop">
              <to>up</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="S-W-Down">
            <action name="SendToDesktop">
              <to>down</to>
              <wrap>no</wrap>
            </action>
          </keybind>
          <keybind key="W-1">
            <action name="GoToDesktop">
              <to>1</to>
            </action>
          </keybind>
          <keybind key="W-2">
            <action name="GoToDesktop">
              <to>2</to>
            </action>
          </keybind>
          <keybind key="W-3">
            <action name="GoToDesktop">
              <to>3</to>
            </action>
          </keybind>
          <keybind key="W-4">
            <action name="GoToDesktop">
              <to>4</to>
            </action>
          </keybind>
          <keybind key="W-z">
            <action name="if">
              <shaded>yes</shaded>
              <then>
                <action name="Focus"/>
                <action name="Raise"/>
              </then>
            </action>
            <action name="ToggleShade"/>
          </keybind>
          <keybind key="W-f">
            <action name="ToggleMaximizeFull"/>
          </keybind>
          <keybind key="W-w">
            <action name="Close"/>
          </keybind>
          <!-- Keybindings for window switching -->
          <keybind key="A-Tab">
            <action name="NextWindow">
              <finalactions>
                <action name="Focus"/>
                <action name="Raise"/>
                <action name="Unshade"/>
              </finalactions>
            </action>
          </keybind>
          <keybind key="A-S-Tab">
            <action name="PreviousWindow">
              <finalactions>
                <action name="Focus"/>
                <action name="Raise"/>
                <action name="Unshade"/>
              </finalactions>
            </action>
          </keybind>
          <!-- Keybindings for window switching with the arrow keys -->
          <keybind key="W-l">
            <action name="DirectionalCycleWindows">
              <direction>right</direction>
            </action>
          </keybind>
          <keybind key="W-h">
            <action name="DirectionalCycleWindows">
              <direction>left</direction>
            </action>
          </keybind>
          <keybind key="W-k">
            <action name="DirectionalCycleWindows">
              <direction>up</direction>
            </action>
          </keybind>
          <keybind key="W-j">
            <action name="DirectionalCycleWindows">
              <direction>down</direction>
            </action>
          </keybind>
          <!-- Keybindings for running applications -->
          <keybind key="W-space">
            <action name="Execute">
              <command>rofi -show run</command>
            </action>
          </keybind>
          <keybind key="A-space">
            <action name="Execute">
              <command>rofi -show run</command>
            </action>
          </keybind>
          <keybind key="F1">
            <action name="Execute">
              <command>rofi -show calc -modi calc -no-show-match -no-sort -lines 2</command>
            </action>
          </keybind>
          <keybind key="F2">
            <action name="Execute">
              <command>rofi -show emoji -modi emoji</command>
            </action>
          </keybind>
          <keybind key="W-d">
            <action name="Execute">
              <command>firefox</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="Print">
            <action name="Execute">
              <command>flameshot gui</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-Return">
            <action name="Execute">
              <command>alacritty</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-Shift-Return">
            <action name="Execute">
              <command>alacritty</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-s">
            <action name="Execute">
              <command>spotify</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-o">
            <action name="Execute">
              <command>obsidian</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-S-s">
            <action name="Execute">
              <command>slack</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-v">
            <action name="Execute">
              <command>pavucontrol</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="W-S-d">
            <action name="Execute">
              <command>discord</command>
              <startupnotify>
                <enabled>yes</enabled>
              </startupnotify>
            </action>
          </keybind>
          <keybind key="XF86AudioPlay">
            <action name="Execute">
              <command>playerctl play-pause</command>
            </action>
          </keybind>
          <keybind key="XF86AudioStop">
            <action name="Execute">
              <command>playerctl stop</command>
            </action>
          </keybind>
          <keybind key="XF86AudioNext">
            <action name="Execute">
              <command>playerctl next</command>
            </action>
          </keybind>
          <keybind key="XF86AudioPrev">
            <action name="Execute">
              <command>playerctl previous</command>
            </action>
          </keybind>
          <keybind key="XF86AudioMute">
            <action name="Execute">
              <command>wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle</command>
            </action>
          </keybind>
          <keybind key="XF86AudioRaiseVolume">
            <action name="Execute">
              <command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+</command>
            </action>
          </keybind>
          <keybind key="XF86AudioLowerVolume">
            <action name="Execute">
              <command>wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-</command>
            </action>
          </keybind>
        </keyboard>
        <mouse>
          <dragThreshold>1</dragThreshold>
          <doubleClickTime>250</doubleClickTime>
          <screenEdgeWarpTime>400</screenEdgeWarpTime>
          <screenEdgeWarpMouse>false</screenEdgeWarpMouse>
          <context name="Frame">
            <mousebind button="A-Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="W-Left" action="Drag">
              <action name="Move"/>
            </mousebind>
            <mousebind button="W-Right" action="Drag">
              <action name="Resize"/>
            </mousebind>
          </context>
          <context name="Titlebar">
            <mousebind button="Left" action="Drag">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Move"/>
            </mousebind>
            <mousebind button="Left" action="DoubleClick">
              <action name="ToggleMaximize"/>
            </mousebind>
            <mousebind button="Up" action="Click">
              <action name="if">
                <shaded>no</shaded>
                <then>
                  <action name="Shade"/>
                </then>
              </action>
            </mousebind>
            <mousebind button="Down" action="Click">
              <action name="if">
                <shaded>yes</shaded>
                <then>
                  <action name="Focus"/>
                  <action name="Raise"/>
                  <action name="Unshade"/>
                </then>
              </action>
            </mousebind>
          </context>
          <context name="Titlebar Top Right Bottom Left TLCorner TRCorner BRCorner BLCorner">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="if">
                <shaded>yes</shaded>
                <then>
                  <action name="Focus"/>
                  <action name="Raise"/>
                </then>
              </action>
              <action name="ToggleShade"/>
            </mousebind>
          </context>
          <context name="Top">
            <mousebind button="Left" action="Drag">
              <action name="Resize">
                <edge>top</edge>
              </action>
            </mousebind>
          </context>
          <context name="Left">
            <mousebind button="Left" action="Drag">
              <action name="Resize">
                <edge>left</edge>
              </action>
            </mousebind>
          </context>
          <context name="Right">
            <mousebind button="Left" action="Drag">
              <action name="Resize">
                <edge>right</edge>
              </action>
            </mousebind>
          </context>
          <context name="Bottom">
            <mousebind button="Left" action="Drag">
              <action name="Resize">
                <edge>bottom</edge>
              </action>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="ShowMenu">
                <menu>client-menu</menu>
              </action>
            </mousebind>
          </context>
          <context name="TRCorner BRCorner TLCorner BLCorner">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
            </mousebind>
            <mousebind button="Left" action="Drag">
              <action name="Resize"/>
            </mousebind>
          </context>
          <context name="Client">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="Middle" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
          </context>
          <context name="Icon">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Unshade"/>
              <action name="ShowMenu">
                <menu>client-menu</menu>
              </action>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="ShowMenu">
                <menu>client-menu</menu>
              </action>
            </mousebind>
          </context>
          <context name="AllDesktops">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
            </mousebind>
            <mousebind button="Left" action="Click">
              <action name="ToggleOmnipresent"/>
            </mousebind>
          </context>
          <context name="Shade">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="Left" action="Click">
              <action name="if">
                <shaded>yes</shaded>
                <then>
                  <action name="Focus"/>
                  <action name="Raise"/>
                </then>
              </action>
              <action name="ToggleShade"/>
            </mousebind>
          </context>
          <context name="Iconify">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="Left" action="Click">
              <action name="Iconify"/>
            </mousebind>
          </context>
          <context name="Maximize">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Unshade"/>
            </mousebind>
            <mousebind button="Middle" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Unshade"/>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Unshade"/>
            </mousebind>
            <mousebind button="Left" action="Click">
              <action name="ToggleMaximize"/>
            </mousebind>
            <mousebind button="Middle" action="Click">
              <action name="ToggleMaximize">
                <direction>vertical</direction>
              </action>
            </mousebind>
            <mousebind button="Right" action="Click">
              <action name="ToggleMaximize">
                <direction>horizontal</direction>
              </action>
            </mousebind>
          </context>
          <context name="Close">
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
              <action name="Unshade"/>
            </mousebind>
            <mousebind button="Left" action="Click">
              <action name="Close"/>
            </mousebind>
          </context>
          <context name="Desktop">
            <mousebind button="Up" action="Click">
              <action name="GoToDesktop">
                <to>previous</to>
              </action>
            </mousebind>
            <mousebind button="Down" action="Click">
              <action name="GoToDesktop">
                <to>next</to>
              </action>
            </mousebind>
            <mousebind button="A-Up" action="Click">
              <action name="GoToDesktop">
                <to>previous</to>
              </action>
            </mousebind>
            <mousebind button="A-Down" action="Click">
              <action name="GoToDesktop">
                <to>next</to>
              </action>
            </mousebind>
            <mousebind button="C-A-Up" action="Click">
              <action name="GoToDesktop">
                <to>previous</to>
              </action>
            </mousebind>
            <mousebind button="C-A-Down" action="Click">
              <action name="GoToDesktop">
                <to>next</to>
              </action>
            </mousebind>
            <mousebind button="Left" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="Focus"/>
              <action name="Raise"/>
            </mousebind>
          </context>
          <context name="Root">
            <!-- Menus -->
            <mousebind button="Middle" action="Press">
              <action name="ShowMenu">
                <menu>client-list-combined-menu</menu>
              </action>
            </mousebind>
            <mousebind button="Right" action="Press">
              <action name="ShowMenu">
                <menu>root-menu</menu>
              </action>
            </mousebind>
          </context>
          <context name="MoveResize">
            <mousebind button="Up" action="Click">
              <action name="GoToDesktop">
                <to>previous</to>
              </action>
            </mousebind>
            <mousebind button="Down" action="Click">
              <action name="GoToDesktop">
                <to>next</to>
              </action>
            </mousebind>
            <mousebind button="A-Up" action="Click">
              <action name="GoToDesktop">
                <to>previous</to>
              </action>
            </mousebind>
            <mousebind button="A-Down" action="Click">
              <action name="GoToDesktop">
                <to>next</to>
              </action>
            </mousebind>
          </context>
        </mouse>
        <menu>
          <file>menu.xml</file>
          <hideDelay>200</hideDelay>
          <middle>no</middle>
          <submenuShowDelay>100</submenuShowDelay>
          <submenuHideDelay>400</submenuHideDelay>
          <showIcons>yes</showIcons>
          <manageDesktops>yes</manageDesktops>
        </menu>
        <applications>
        </applications>
      </openbox_config>
    '';

    xdg.configFile."openbox/menu.xml".text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <openbox_menu xmlns="http://openbox.org/3.4/menu">
      <menu id="root-menu" label="Openbox 3">
        <separator label="APPLICATIONS" />
        <item label="ALACRITTY">
          <action name="Execute">
            <command>alacritty</command>
            <startupnotify>
              <enabled>yes</enabled>
            </startupnotify>
          </action>
        </item>
        <item label="FIREFOX">
          <action name="Execute">
            <command>firefox</command>
            <startupnotify>
              <enabled>yes</enabled>
            </startupnotify>
          </action>
        </item>
        <item label="SLACK">
          <action name="Execute">
            <command>slack</command>
          </action>
        </item>
        <item label="DISCORD">
          <action name="Execute">
            <command>discord</command>
          </action>
        </item>
        <item label="SPOTIFY">
          <action name="Execute">
            <command>spotify</command>
          </action>
        </item>
        <item label="ZOOM">
          <action name="Execute">
            <command>zoom-us</command>
          </action>
        </item>
        <separator label="VIRTUALIZATION" />
        <item label="SINGLE-MONITOR">
          <action name="Execute">
            <command>xrandr --output HDMI-1 --off</command>
            <startupnotify><enabled>yes</enabled></startupnotify>
          </action>
        </item>
        <item label="DUAL-MONITOR">
          <action name="Execute">
            <command>xrandr --output HDMI-1 --mode 2560x1440 --right-of DP-1</command>
            <startupnotify><enabled>yes</enabled></startupnotify>
          </action>
        </item>
        <item label="START-WIN10">
          <action name="Execute">
            <command>virsh start windows</command>
          </action>
        </item>
        <separator label="SYSTEM" />
        <item label="VOLUME CONTROL">
          <action name="Execute">
            <command>pavucontrol</command>
          </action>
        </item>
        <separator label="OPENBOX" />
        <item label="RELOAD CONFIG">
          <action name="Reconfigure" />
        </item>
        <separator />
        <item label="LOGOFF">
          <action name="Exit">
            <prompt>yes</prompt>
          </action>
        </item>
        <item label="REBOOT">
          <action name="Execute">
            <prompt>Reboot Computer?</prompt>
            <command>reboot</command>
          </action>
        </item>
        <item label="SHUTDOWN">
          <action name="Execute">
            <prompt>Shutdown Computer?</prompt>
            <command>poweroff</command>
          </action>
        </item>
      </menu>
      </openbox_menu>
    '';

    home.file = {
      ".themes/nix-openbox/openbox-3/themerc".text = ''
        #======================================
        #     Menu Settings
        #======================================
        menu.title.bg: raised
        menu.title.bg.color: #${colors.base01}
        menu.title.text.color: #${colors.base05}
        menu.separator.color: #${colors.base01}
        menu.items.bg: raised
        menu.items.bg.color: #${colors.base00}
        menu.items.text.color: #${colors.base05}
        menu.items.disabled.text.color: #${colors.base03}
        menu.items.active.bg: flat border
        menu.items.active.bg.color: #${colors.base01}
        menu.items.active.bg.border.color: #${colors.base01}
        menu.items.active.text.color: #${colors.base05}

        #======================================
        #     Focused Window Settings
        #======================================
        window.active.title.bg: raised
        window.active.title.bg.color: #${colors.base00}
        window.active.handle.bg: raised
        window.active.handle.bg.color: #${colors.base00}
        window.active.grip.bg: parentrelative
        window.active.label.bg: parentrelative
        window.active.label.text.color: #${colors.base05}
        window.*.button.*.bg: parentrelative
        window.active.button.*.image.color: #${colors.base05}
        window.active.button.*.pressed.image.color: #${colors.base00}
        window.active.button.disabled.image.color: #${colors.base05}

        #======================================
        #     Unfocused Window Settings
        #======================================

        window.inactive.title.bg: raised
        window.inactive.title.bg.color: #${colors.base00}
        window.inactive.handle.bg: raised
        window.inactive.handle.bg.color: #${colors.base00}
        window.inactive.grip.bg: parentrelative
        window.inactive.label.bg: parentrelative
        window.inactive.label.text.color: #${colors.base03}
        window.inactive.button.*.image.color: #${colors.base05}

        #======================================
        #     Global Width Settings
        #======================================

        padding.width: 1
        padding.height: 1
        border.width: 1
        window.handle.width: 3
        window.client.padding.width: 0
        menu.overlap.x: -5

        #======================================
        #     Miscellaneous Settings
        #======================================

        border.color: #${colors.base00}
        menu.border.color: #${colors.base00}

        #======================================
        #     Osd
        #======================================

        osd.hilight.bg: flat border
        osd.hilight.bg.color: #${colors.base0D}
        osd.hilight.bg.border.color: #${colors.base09}

        #======================================
        #     Title Justification
        #======================================

        menu.title.text.justify: center
        window.label.text.justify: center
      '';


      ".themes/nix-openbox/openbox-3/bullet.xbm".text = ''
        #define bullet_width 5
        #define bullet_height 5
        static unsigned char bullet_bits[] = {
          0x02, 0x06, 0x0e, 0x06, 0x02 };
      '';

      ".themes/nix-openbox/openbox-3/close.xbm".text = ''
        #define close_width 5
        #define close_height 5
        static unsigned char close_bits[] = {
          0x11, 0x0a, 0x04, 0x0a, 0x11 };
      '';

      ".themes/nix-openbox/openbox-3/iconify.xbm".text = ''
        #define iconify_width 5
        #define iconify_height 5
        static unsigned char iconify_bits[] = {
          0x10, 0x08, 0x04, 0x02, 0x01 };
      '';

      ".themes/nix-openbox/openbox-3/max.xbm".text = ''
        #define max_width 5
        #define max_height 5
        static unsigned char max_bits[] = {
          0x0e, 0x11, 0x11, 0x11, 0x0e };

      '';

      ".themes/nix-openbox/openbox-3/shade.xbm".text = ''
        #define shade_width 5
        #define shade_height 5
        static unsigned char shade_bits[] = {
           0x04, 0x0a, 0x11, 0x04, 0x0a };
      '';

      ".themes/nix-openbox/openbox-3/shade_toggled.xbm".text = ''
        #define shade_toggled_width 5
        #define shade_toggled_height 5
        static unsigned char shade_toggled_bits[] = {
           0x0a, 0x04, 0x11, 0x0a, 0x04 };
      '';
    };
  };
}
