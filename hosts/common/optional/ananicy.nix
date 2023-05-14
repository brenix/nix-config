{ pkgs, ... }:
{
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    settings = {
      check_freq = 15;
      cgroup_load = true;
      type_load = true;
      rule_load = true;
      apply_nice = true;
      apply_latnice = true;
      apply_ioclass = true;
      apply_ionice = true;
      apply_sched = true;
      apply_oom_score_adj = true;
      apply_cgroup = true;
      check_disks_schedulers = true;
    };

    # Rules taken from CachyOS/ananicy-rules
    extraRules = ''
      # Type: Game
      # Use more CPU time if possible
      # Games do not always need more IO, but in most cases can be hungry for CPU
      { "type": "Game", "nice": -7, "ioclass": "best-effort", "latency_nice": -7 }

      # Type: Player Audio/Video
      # Try to add more CPU power to decrease latency/lags
      # Try to add real time io for avoiding lags
      { "type": "Player-Audio", "nice": -4, "latency_nice": -4 }
      { "type": "Player-Video", "nice": -4, "latency_nice": -4 }

      # Must have more CPU/IO time, but not so much as other apps
      { "type": "Image-View", "nice": -4, "latency_nice": -4 }
      { "type": "Doc-View",   "nice": -4, "latency_nice": -4 }

      # Type: Low Latency Realtime Apps
      # In general case not so heavy, but must not lag
      { "type": "LowLatency_RT", "nice": -9, "ioclass": "best-effort", "latency_nice": -9 }

      # Type: BackGround CPU/IO Load
      # Background CPU/IO it's needed, but it must be as silent as possible
      { "type": "BG_CPUIO", "nice": 16, "ioclass": "idle", "sched": "idle", "latency_nice": 11 }

      # Type: Heavy CPU Load
      # It must work fast enough but must not create so much noise
      { "type": "Heavy_CPU", "nice": 9, "ioclass": "best-effort", "ionice": 7, "latency_nice": 9 }

      # Type: Chat
      { "type": "Chat", "nice": -3, "ioclass": "best-effort", "ionice": 7 , "latency_nice": -3 }

      # Type: Compiler
      { "type":"compiler", "nice": 9, "latency_nice": 9 }

      # Type: Service
      { "type": "Service", "nice": 10, "ioclass": "best-effort", "ionice": 6 , "latency_nice": 10 }

      # Type: Indifference
      { "type": "IN_DIFF", "nice": 0, "ioclass": "best-effort", "ionice": 7 , "latency_nice": 0 }

      # Type: Adj OOM Score
      { "type": "OOM_KILL", "oom_score_adj": 1000 }
      { "type": "OOM_NO_KILL", "oom_score_adj": -1000 }

      { "cgroup": "cpu90", "CPUQuota": 90 }
      { "cgroup": "cpu85", "CPUQuota": 85 }
      { "cgroup": "cpu80", "CPUQuota": 80 }

      { "name": "spotify", "type": "Player-Audio" }
      { "name": "calibre", "type": "Doc-View" }
      { "name": "ebook-viewer", "type": "Doc-View" }
      { "name": "lrfviewer", "type": "Doc-View" }
      { "name": "boinc", "type": "Heavy_CPU" }
      { "name": "clang-tidy", "type": "BG_CPUIO" }
      { "name": "collectd", "type": "BG_CPUIO" }
      { "name": "clang", "type": "compiler" }
      { "name": "clang++", "type": "compiler" }
      { "name": "gcc", "type": "compiler" }
      { "name": "g++", "type": "compiler" }
      { "name": "cen64", "type": "Game"}
      { "name": "cen64-qt", "type": "Game"}
      { "name": "celluloid", "type": "Player-Video" }
      { "name": "clamd", "type": "BG_CPUIO" }
      { "name": "go", "type": "compiler" }
      { "name": "xmobar", "type": "LowLatency_RT" }
      { "name": "xmonad-x86_64-linux", "type": "LowLatency_RT" }
      { "name": "borg", "type": "BG_CPUIO" }# Music player: https://www.clementine-player.org
      { "name": "clementine", "type": "Player-Audio" }
      { "name": "clementine-tagreader", "type": "Player-Audio" }
      { "name": "blueman-applet", "type": "BG_CPUIO" }
      { "name": "blueberry-tray", "type": "BG_CPUIO" }
      { "name": "cmus", "type": "Player-Audio" }
      { "name": "lld", "type": "compiler" }
      { "name": "mold", "type": "compiler" }
      { "name": "ld", "type": "compiler" }
      { "name": "ld.bfd", "type": "compiler" }
      { "name": "ld.mold", "type": "compiler" }
      { "name": "ld.lld", "type": "compiler" }
      { "name": "lto1-ltrans", "type": "compiler" }
      { "name": "cargo", "type": "compiler" }
      { "name": "rustc", "type": "compiler" }
      { "name": "rust-analyzer", "type": "compiler" }
      { "name": "awesome", "type": "LowLatency_RT" }
      { "name": "bspwm", "type": "LowLatency_RT" }
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "gdm", "type": "LowLatency_RT"}
      { "name": "gdm-wayland-session", "type": "LowLatency_RT"}# http://live.gnome.org/ThumbnailerSpec
      { "name": "tumblerd", "type": "TODO" }
      { "name": "gnome-keyring-daemon", "type": "Service"}
      { "name": "gdm-session-worker", "type": "Service"}
      { "name": "polkit-gnome-authentication-agent-1", "type": "Service"}# https://github.com/chjj/compton
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "lxdm-binary", "type": "LowLatency_RT"}
      { "name": "lxdm-session", "type": "LowLatency_RT"}
      { "name": "Hyprland", "type": "LowLatency_RT" }
      { "name": "lightdm", "type": "LowLatency_RT" }
      { "name": "i3", "type": "LowLatency_RT" }
      { "name": "openbox", "type": "LowLatency_RT" }
      { "name": "polybar", "type": "LowLatency_RT" }
      { "name": "plank", "type": "LowLatency_RT" }
      { "name": "baloo_file", "type": "BG_CPUIO" }
      { "name": "krunner",      "type": "LowLatency_RT" }
      { "name": "kwin_x11",     "type": "LowLatency_RT" }
      { "name": "kwin_wayland", "type": "LowLatency_RT"}
      { "name": "kwin_wayland_wrapper", "type": "LowLatency_RT"}
      { "name": "plasmashell",  "nice": -1 }
      { "name": "kdeconnectd",  "type": "BG_CPUIO" }
      { "name": "sddm", "type": "LowLatency_RT"}
      { "name": "sddm-helper", "type": "LowLatency_RT"}
      { "name": "spectrwm", "type": "LowLatency_RT" }
      { "name": "sway", "type": "LowLatency_RT" }
      { "name": "weston", "type": "LowLatency_RT" }
      { "name":"xfwm4",           "type":"LowLatency_RT"}
      { "name":"xfsettingsd",     "type":"LowLatency_RT"}
      { "name":"xfce4-session",   "type":"LowLatency_RT"}
      { "name":"xfconfd",         "type":"LowLatency_RT"}
      { "name":"xfce4-appfinder", "type":"LowLatency_RT"}
      { "name":"xfce4-notifyd",   "type":"LowLatency_RT"}
      { "name":"xfce4-panel",     "type":"LowLatency_RT"}
      { "name":"xfdesktop",       "type":"LowLatency_RT"}
      { "name": "xmobar", "type": "LowLatency_RT" }
      { "name": "xmonad-x86_64-linux", "type": "LowLatency_RT" }
      { "name": "Xwayland", "type": "LowLatency_RT"}
      { "name": "Xorg", "nice" : -12, "ionice" : 1, "latency_nice" : -10 }
      { "name": "FoxitReader", "type": "Doc-View" }
      { "name": "file-roller", "type": "BG_CPUIO" }
      { "name": "SVPManager", "type": "Player-Video" }
      { "name": "konsole", "type": "Doc-View" }
      { "name": "st", "type": "Doc-View" }
      { "name": "alacritty", "type": "Doc-View" }
      { "name": "kitty", "type": "Doc-View" }
      { "name": "hyper", "type": "Doc-View" }
      { "name": "mosh", "type": "Doc-View" }
      { "name": "foot", "type": "Doc-View" }
      { "name": "footclient", "type": "Doc-View" }
      { "name": "gnome-terminal-server", "type": "Doc-View" }
      { "name": "wezterm-gui", "type": "Doc-View" }
      { "name": "openvpn", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "Remnant-Win64-Shipping.exe", "type": "Game"}
      { "name": "Remnant.exe", "type": "Game"}
      { "name": "mullvad-daemon", "type": "IN_DIFF" }
      { "name": "mullvad-gui", "type": "IN_DIFF" }
      { "name": "tailscaled", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "openvpn", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "alarm-clock", "type": "BG_CPUIO" }
      { "name": "wg", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "wg-quick", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "acestreamengine",    "type": "Player-Video" }
      { "name": "acestream-launcher", "type": "Player-Video" }
      { "name": "acestream-player",   "type": "Player-Video" }
      { "name": "amule", "type": "BG_CPUIO" }
      { "name": "android-studio", "type": "Heavy_CPU" }
      { "name": "avd", "type": "Heavy_CPU" }# aria2 - lightweight download utility: https://aria2.github.io/
      { "name": "aria2c", "type": "BG_CPUIO" }
      { "name": "ario", "type": "Player-Audio" }
      { "name": "ark", "type": "BG_CPUIO"}
      { "name": "bees", "type": "BG_CPUIO", "oom_score_adj": 1000 }
      { "name": "ArchiSteamFarm", "type": "BG_CPUIO" }
      { "name": "blender", "type": "LowLatency_RT", "nice": -10, "ioclass": "realtime" }
      { "name": "bitwig-studio",      "type": "LowLatency_RT" }
      { "name": "BitwigStudioEngine", "type": "LowLatency_RT" }
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "blastem", "type": "Game"}
      { "name": "flutter", "type": "Heavy_CPU" }
      { "name": "dart", "type": "Heavy_CPU" }# Music player: http://deadbeef.sourceforge.net/
      { "name": "deadbeef-gtkui", "type": "Player-Audio" }
      { "name": "deluged", "type": "BG_CPUIO" }
      { "name": "deluge",  "type": "BG_CPUIO" }
      { "name": "d1x-rebirth", "type": "Game"}
      { "name": "d2x-rebirth", "type": "Game"}
      { "name": "dnsmasq", "type": "Doc-View" }
      { "name": "DisplayLinkManager", "type": "LowLatency_RT" }
      { "name": "dolphin-emu", "type": "Game"}
      { "name": "eog", "type": "Image-View" }
      { "name": "dropbox", "type": "BG_CPUIO" }
      { "name": "eduke32", "type": "Game"}
      { "name": "dupeguru", "type": "Heavy_CPU" }
      { "name": "duperemove", "type": "BG_CPUIO" }
      { "name": "et", "type": "Game"}
      { "name": "et.x86", "type": "Game"}
      { "name": "etl", "type": "Game"}
      { "name": "FAHClient", "type": "Heavy_CPU" }
      { "name": "fdupes", "type": "BG_CPUIO" }
      { "name": "evince", "type": "Doc-View" }
      { "name": "feh", "type": "Image-View" }
      { "name": "fail2ban-server", "type": "BG_CPUIO" }# ffmpeg - audio and video converter: https://www.ffmpeg.org/
      { "name": "ffmpeg", "type": "LowLatency_RT" }
      { "name": "fluxbox", "type": "LowLatency_RT" }
      { "name": "fs-uae", "type": "Game"}
      { "name": "fs-uae-devel", "type": "Game"}
      { "name": "Battlerite.exe", "type": "Game" }
      { "name": "0ad", "type": "Game" }
      { "name": "DOOMEternalx64vk.exe", "type": "Game"}
      { "name": "Overwatch.exe", "type": "Game"}
      { "name": "Remnant-Win64-Shipping.exe", "type": "Game"}
      { "name": "Remnant.exe", "type": "Game"}
      { "name": "RocketLeague.exe", "type": "Game"}
      { "name": "GameClient.exe", "type": "Game" }
      { "name": "Indiana-Win64-Shipping.exe", "type": "Game"}
      { "name": "TheOuterWorlds.exe", "type": "Game"}
      { "name": "Universe", "type": "Game"}
      { "name": "R5Apex.exe", "type": "Game"}
      { "name": "R5Apex_dx12.exe", "type": "Game"}
      { "name": "AvP_Classic.exe", "type": "Game"}
      { "name": "AvP.exe", "type": "Game"}
      { "name": "AvP_DX11.exe", "type": "Game"}
      { "name": "TERA.exe", "type": "Game" }
      { "name": "anox.exe", "type": "Game"}
      { "name": "Steam.exe", "type": "BG_CPUIO" }
      { "name": "steamwebhelper.exe", "type": "BG_CPUIO" }
      { "name": "AssassinsCreed_Dx9.exe", "type": "Game"}
      { "name": "AssassinsCreed_Dx10.exe", "type": "Game"}
      { "name": "AssassinsCreedIIGame.exe", "type": "Game"}
      { "name": "ACBSP.exe", "type": "Game"}
      { "name": "ACBMP.exe", "type": "Game"}
      { "name": "ACRMP.exe", "type": "Game"}
      { "name": "ACRPR.exe", "type": "Game"}
      { "name": "ACRSP.exe", "type": "Game"}
      { "name": "AC3SP.exe", "type": "Game"}
      { "name": "AC3MP.exe", "type": "Game"}
      { "name": "AC4BFMP.exe", "type": "Game"}
      { "name": "AC4BFSP.exe", "type": "Game"}
      { "name": "ACC.exe", "type": "Game"}
      { "name": "ACU.exe", "type": "Game"}
      { "name": "ACS.exe", "type": "Game"}
      { "name": "ACOrigins.exe", "type": "Game"}
      { "name": "ACOdyssey.exe", "type": "Game"}
      { "name": "Audiosurf2.x86_64", "type": "Game"}
      { "name": "bf1.exe", "type": "Game"}
      { "name": "bf1Trial.exe", "type": "Game"}
      { "name": "BatmanAK.exe", "type": "Game"}
      { "name": "BatmanOriginsOnline.exe", "type": "Game"}
      { "name": "BatmanAC.exe", "type": "Game"}
      { "name": "ShippingPC-BmGame.exe", "type": "Game"}
      { "name": "BeamNG.drive.x64.exe", "type": "Game"}
      { "name": "BeamNG.drive.x64", "type": "Game"}
      { "name": "Bioshock.exe", "type": "Game"}
      { "name": "BioshockHD.exe", "type": "Game"}
      { "name": "Bioshock2.exe", "type": "Game"}
      { "name": "Bioshock2HD.exe", "type": "Game"}
      { "name": "BioShockInfinite.exe", "type": "Game"}
      { "name": "BeyondTwoSouls_", "type": "Game"}
      { "name": "CoDMP.exe", "type": "Game" }
      { "name": "CoDSP.exe", "type": "Game" }
      { "name": "CoD2MP_s.exe", "type": "Game" }
      { "name": "CoD2SP_s.exe", "type": "Game" }
      { "name": "iw3sp.exe", "type": "Game" }
      { "name": "iw3mp.exe", "type": "Game" }
      { "name": "CoDWaW.exe", "type": "Game" }
      { "name": "CoDWaWmp.exe", "type": "Game" }
      { "name": "CoDUOMP.exe", "type": "Game" }
      { "name": "CoDUOSP.exe", "type": "Game" }
      { "name": "iw4sp.exe", "type": "Game" }
      { "name": "iw4mp.exe", "type": "Game" }
      { "name": "rayne.exe", "type": "Game"}
      { "name": "br2.exe", "type": "Game"}
      { "name": "bloodrayne.exe", "type": "Game"}
      { "name": "rayne1.exe", "type": "Game"}
      { "name": "rayne2.exe", "type": "Game"}
      { "name": "BloodstainedRotN.exe", "type": "Game"}
      { "name": "BloodstainedRotN-Win64-Shipping.exe", "type": "Game"}
      { "name": "COTM.exe", "type": "Game"}
      { "name": "BloonsTD6.exe", "type": "Game" }
      { "name": "BTD5-Win.exe", "type": "Game" }
      { "name": "btdb2_game.exe", "type": "Game" }
      { "name": "Borderlands3.exe", "type": "Game"}
      { "name": "Borderlands2.exe", "type": "Game"}
      { "name": "BorderlandsPreSequel.exe", "type": "Game"}
      { "name": "Borderlands.exe", "type": "Game"}
      { "name": "BorderlandsGOTY.exe", "type": "Game"}
      { "name": "CoCMainWin32.exe", "type": "Game"}
      { "name": "CallOfCthulhu.exe", "type": "Game"}
      { "name": "Cthulhu.exe", "type": "Game"}
      { "name": "CLOS2.exe", "type": "Game"}
      { "name": "CastlevaniaLoSUE.exe", "type": "Game"}
      { "name": "CMOF.exe", "type": "Game"}
      { "name": "ClientG.exe", "type": "Game"}
      { "name": "Chaser.exe", "type": "Game"}
      { "name": "CoJGunslinger.exe", "type": "Game"}
      { "name": "t6sp.exe", "type": "Game"}
      { "name": "t6mp.exe", "type": "Game"}
      { "name": "t6zm.exe", "type": "Game"}
      { "name": "Cities.x64", "type": "Game"}
      { "name": "player.exe", "type": "Game"}
      { "name": "Game.exe", "type": "Game"}
      { "name": "game.exe", "type": "Game"}
      { "name": "Condemned.exe", "type": "Game"}
      { "name": "Cyberpunk 2077.exe", "type": "Game"}
      { "name": "Redprelauncher", "type": "game-launcher"}
      { "name": "DarkSoulsRemastered.exe", "type": "Game"}
      { "name": "DarkSoulsII.exe", "type": "Game"}
      { "name": "DarkSoulsIII.exe", "type": "Game"}
      { "name": "Dead Space.exe", "type": "Game"}
      { "name": "deadspace2.exe", "type": "Game"}
      { "name": "deadspace3.exe", "type": "Game"}
      { "name": "DeusEx.exe", "type": "Game"}
      { "name": "deusex.exe", "type": "Game"}
      { "name": "Revision.exe", "type": "Game"}
      { "name": "DXMD.exe", "type": "Game"}
      { "name": "DXHRDC.exe", "type": "Game"}
      { "name": "DX2Main.exe", "type": "Game"}
      { "name": "dx2.exe", "type": "Game"}
      { "name": "Deceit.exe", "type": "Game"}
      { "name": "devilutionx", "type": "Game"}
      { "name": "DetroitBecomeHu", "type": "Game"}
      { "name": "Diablo III64.exe", "type": "Game" }
      { "name": "EoCApp.exe", "type": "Game"}
      { "name": "dis1_st.exe", "type": "Game"}
      { "name": "disgaea2.exe", "type": "Game"}
      { "name": "Disgaea4pc.exe", "type": "Game"}
      { "name": "disgaea5.exe", "type": "Game"}
      { "name": "Dishonored.exe", "type": "Game"}
      { "name": "Dishonored2.exe", "type": "Game"}
      { "name": "chocolate-doom", "type": "Game"}
      { "name": "zdoom", "type": "Game"}
      { "name": "gzdoom", "type": "Game"}
      { "name": "dhewm3", "type": "Game"}
      { "name": "rbdoom3bfg", "type": "Game"}
      { "name": "duke3d.exe", "type": "Game"}
      { "name": "Origin.exe", "type": "BG_CPUIO" }
      { "name": "EAStreamProxy.exe", "type": "BG_CPUIO" }
      { "name": "QtWebEngineProcess.exe", "type": "BG_CPUIO" }
      { "name": "DXBall2.exe", "type": "Game"}
      { "name": "DAOrigins.exe", "type": "Game"}
      { "name": "DragonAge2.exe", "type": "Game"}
      { "name": "DragonAgeInquisition.exe", "type": "Game"}
      { "name": "EADesktop.exe", "type": "BG_CPUIO" }
      { "name": "EALauncher.exe", "type": "BG_CPUIO" }
      { "name": "EAStreamProxy.exe", "type": "BG_CPUIO" }
      { "name": "Link2EA.exe", "type": "BG_CPUIO" }
      { "name": "EALaunchHelper.exe", "type": "BG_CPUIO" }
      { "name": "EABackgroundService.exe", "type": "BG_CPUIO" }
      { "name": "EACrashReporter.exe", "type": "BG_CPUIO" }
      { "name": "EAConnect_microsoft.exe", "type": "BG_CPUIO" }
      { "name": "EAGEP.exe", "type": "BG_CPUIO" }
      { "name": "EAUninstall.exe", "type": "BG_CPUIO" }
      { "name": "ErrorReporter.exe", "type": "BG_CPUIO" }
      { "name": "GetGameToken32.exe", "type": "BG_CPUIO" }
      { "name": "GetGameToken64.exe", "type": "BG_CPUIO" }
      { "name": "IGOProxy32.exe", "type": "BG_CPUIO" }
      { "name": "OriginLegacyCompatibility.exe", "type": "BG_CPUIO" }
      { "name": "QtWebEngineProcess.exe", "type": "BG_CPUIO" }
      { "name": "DungeonSiege.exe", "type": "Game"}
      { "name": "DungeonSiege2.exe", "type": "Game"}
      { "name": "Dungeon Siege III.exe", "type": "Game"}
      { "name": "DOOM64_x64.exe", "type": "Game"}
      { "name": "Environmental Station Alpha.exe", "type": "Game"}
      { "name": "EpicGamesLauncher.exe", "type": "BG_CPUIO" }
      { "name": "EpicWebHelper.exe", "type": "BG_CPUIO" }
      { "name": "Fable Anniversary.exe", "type": "Game"}
      { "name": "Fable.exe", "type": "Game"}
      { "name": "Expendable.exe", "type": "Game"}
      { "name": "EvilDead.exe", "type": "Game" }
      { "name": "EvilDead-Win64-Shipping.exe", "type": "Game" }
      { "name": "falloutw.exe", "type": "Game"}
      { "name": "FALLOUT2.exe", "type": "Game"}
      { "name": "fallout2.exe", "type": "Game"}
      { "name": "fallout2HR.exe", "type": "Game"}
      { "name": "FalloutClient.exe", "type": "Game"}
      { "name": "Fallout3.exe", "type": "Game"}
      { "name": "Fallout3 - Garden of Eden Creation Kit.exe", "type": "Game"}
      { "name": "FalloutNV.exe", "type": "Game"}
      { "name": "Fallout4.exe", "type": "Game"}
      { "name": "Fallout76.exe", "type": "Game"}
      { "name": "FEAR.exe", "type": "Game"}
      { "name": "FEARMP.exe", "type": "Game"}
      { "name": "FEARXP.exe", "type": "Game"}
      { "name": "FEARXP2.exe", "type": "Game"}
      { "name": "FEAR2.exe", "type": "Game"}
      { "name": "F.E.A.R. 3.exe", "type": "Game"}
      { "name": "com.github.tkashkin.gamehub", "type": "BG_CPUIO" }
      { "name": "grandia.exe", "type": "Game"}
      { "name": "grandia2.exe", "type": "Game"}
      { "name": "GOTHIC.EXE", "type": "Game"}
      { "name": "GothicMod.exe", "type": "Game"}
      { "name": "Gothic2.exe", "type": "Game"}
      { "name": "Gothic3.exe", "type": "Game"}
      { "name": "gmod", "type": "Game"}
      { "name": "GTA5.exe", "type": "Game"}
      { "name": "GTAIV.exe", "type": "Game"}
      { "name": "gta-sa.exe", "type": "Game"}
      { "name": "gta-vc.exe", "type": "Game"}
      { "name": "gta3.exe", "type": "Game"}
      { "name": "gta2.exe", "type": "Game"}
      { "name": "Grand Theft Auto.exe", "type": "Game"}
      { "name": "Golf With Your Friends.x86_64", "type": "Game"}
      { "name": "GenshinImpact.exe", "type": "Game"}
      { "name": "YuanShen.exe", "type": "Game"}
      { "name": "heroic", "type": "Doc-View" }
      { "name": "legendary", "type": "IN_DIFF" }
      { "name": "gogdl", "type": "BG_CPUIO" }
      { "name": "Hitman.Exe", "type": "Game"}
      { "name": "hitman2.exe", "type": "Game"}
      { "name": "HitmanContracts.exe", "type": "Game"}
      { "name": "HitmanBloodMoney.exe", "type": "Game"}
      { "name": "HMA.exe", "type": "Game"}
      { "name": "HITMAN.exe", "type": "Game"}
      { "name": "HITMAN2.exe", "type": "Game"}
      { "name": "il2fb.exe", "type": "Game"}
      { "name": "insurgency_linux", "type": "Game"}
      { "name": "hoi4", "type": "Game"}
      { "name": "hoi4.exe", "type": "Game"}
      { "name": "Dredd.exe", "type": "Game"}
      { "name": "JustCause2.exe", "type": "Game" }
      { "name": "LastBlade.exe", "type": "Game"}
      { "name": "LastBlade2App.exe", "type": "Game"}
      { "name": "Killer7Win.exe", "type": "Game"}
      { "name": "KidGame.exe", "type": "Game"}
      { "name": "KFGame.exe", "type": "Game" }
      { "name": "kofxiii.exe", "type": "Game"}
      { "name": "kofxiv.exe", "type": "Game"}
      { "name": "KingOfFighters2002UM.exe", "type": "Game"}
      { "name": "KingOfFighters2002UM_x64.exe", "type": "Game"}
      { "name": "KingOfFighters98UM.exe", "type": "Game"}
      { "name": "KOF97.exe", "type": "Game"}
      { "name": "kingpin.exe", "type": "Game"}
      { "name": "LEGOStarWarsSaga.exe", "type": "Game"}
      { "name": "LEGOCloneWars.exe", "type": "Game"}
      { "name": "LEGOSWTFA.exe", "type": "Game"}
      { "name": "LEGOSWTFA_DX11.exe", "type": "Game"}
      { "name": "LEGOMARVEL2.exe", "type": "Game"}
      { "name": "LEGOMARVEL2_DX11.exe", "type": "Game"}
      { "name": "LEGO DC Super-villains_DX11.exe", "type": "Game"}
      { "name": "LEGOMARVEL.exe", "type": "Game"}
      { "name": "LEGOPirates.exe", "type": "Game"}
      { "name": "LEGOLOTR.exe", "type": "Game"}
      { "name": "LEGOHarryPotter.exe", "type": "Game"}
      { "name": "harry2.exe", "type": "Game"}
      { "name": "LEGOBatman3.exe", "type": "Game"}
      { "name": "LEGOBatman3_DX11.exe", "type": "Game"}
      { "name": "LEGO_Worlds.exe", "type": "Game"}
      { "name": "LEGO_Worlds_DX11.exe", "type": "Game"}
      { "name": "LEGOMARVELAvengers.exe", "type": "Game"}
      { "name": "LEGOMARVELAvengers_DX11.exe", "type": "Game"}
      { "name": "LEGOJurassicWorld.exe", "type": "Game"}
      { "name": "LEGOJurassicWorld_DX11.exe", "type": "Game"}
      { "name": "LEGOHobbit.exe", "type": "Game"}
      { "name": "LEGOHobbit_DX11.exe", "type": "Game"}
      { "name": "LEGOIndy.exe", "type": "Game"}
      { "name": "LEGOLCUR_DX11.exe", "type": "Game"}
      { "name": "LEGOBatman.exe", "type": "Game"}
      { "name": "LEGO The Incredibles.exe", "type": "Game"}
      { "name": "LEGO The Incredibles_DX11.exe", "type": "Game"}
      { "name": "LEGONINJAGO.exe", "type": "Game"}
      { "name": "LEGONINJAGO_DX11.exe", "type": "Game"}
      { "name": "LEGOIndy2.exe", "type": "Game"}
      { "name": "LEGOBatman2.exe", "type": "Game"}
      { "name": "LEGOEMMET.exe", "type": "Game"}
      { "name": "LEGO The LEGO Movie 2_DX11.exe", "type": "Game"}
      { "name": "left4dead.exe", "type": "Game" }
      { "name": "LANoire.exe", "type": "Game"}
      { "name": "manhunt.exe", "type": "Game"}
      { "name": "minetest", "type": "Game" }
      { "name": "maxpayne.exe", "type": "Game"}
      { "name": "maxpayne2.exe", "type": "Game"}
      { "name": "MaxPayne3.exe", "type": "Game"}
      { "name": "MassEffect.exe", "type": "Game"}
      { "name": "MassEffect2.exe", "type": "Game"}
      { "name": "MassEffect3.exe", "type": "Game"}
      { "name": "Minoria.exe", "type": "Game"}
      { "name": "Morrowind.exe", "type": "Game"}
      { "name": "Nosferatu.exe", "type": "Game"}
      { "name": "NinoKuni_WotWW_Remastered.exe", "type": "Game"}
      { "name": "Nino2.exe", "type": "Game"}
      { "name": "Octopath_Traveler.exe", "type": "Game"}
      { "name": "Octopath_Traveler-Win64-Shipping.exe", "type": "Game"}
      { "name": "pso2.exe", "type": "Game" }
      { "name": "Oblivion.exe", "type": "Game"}
      { "name": "PKHDGame-Win32-Shipping.ex", "type": "Game"}
      { "name": "Painkiller.exe", "type": "Game"}
      { "name": "Overdose.exe", "type": "Game"}
      { "name": "RecurringEvil.exe", "type": "Game"}
      { "name": "Redemption.exe", "type": "Game"}
      { "name": "Resurrection.exe", "type": "Game"}
      { "name": "osu!", "type": "Game"}
      { "name": "osu!.exe", "type": "Game"}
      { "name": "tyr-quake", "type": "Game"}
      { "name": "tyr-glquake", "type": "Game"}
      { "name": "tyr-qwcl", "type": "Game"}
      { "name": "tyr-glqwcl", "type": "Game"}
      { "name": "vkquake", "type": "Game"}
      { "name": "quakespasm", "type": "Game"}
      { "name": "quakespasm-svn", "type": "Game"}
      { "name": "quake2", "type": "Game"}
      { "name": "yamagi-quake2", "type": "Game"}
      { "name": "yamagi-quake2-git", "type": "Game"}
      { "name": "vkquake2", "type": "Game"}
      { "name": "quake3", "type": "Game"}
      { "name": "ioquake3", "type": "Game"}
      { "name": "ravenfield.x86_64", "type": "Game"}
      { "name": "RelicCoH2.exe", "type": "Game"}
      { "name": "RF.exe", "type": "Game"}
      { "name": "RF_120na.exe", "type": "Game"}
      { "name": "rf2.exe", "type": "Game"}
      { "name": "RedFactionArmageddon.exe", "type": "Game"}
      { "name": "RedFactionArmageddon_DX11.exe", "type": "Game"}
      { "name": "rfg.exe", "type": "Game"}
      { "name": "RFG.exe", "type": "Game"}
      { "name": "re7.exe", "type": "Game"}
      { "name": "re2.exe", "type": "Game"}
      { "name": "re3.exe", "type": "Game"}
      { "name": "bio4.exe", "type": "Game"}
      { "name": "BH6.exe", "type": "Game"}
      { "name": "re5dx9.exe", "type": "Game"}
      { "name": "re0hd.exe", "type": "Game"}
      { "name": "rerev2.exe", "type": "Game"}
      { "name": "bhd.exe", "type": "Game"}
      { "name": "rerev.exe", "type": "Game"}
      { "name": "RaccoonCity.exe", "type": "Game"}
      { "name": "riot-web", "type": "LowLatency_RT" }
      { "name": "RimWorldLinux", "type": "Game" }
      { "name": "fossilize_replay", "type": "BG_CPUIO"}
      { "name": "R-Type_Dimensions.exe", "type": "Game"}
      { "name": "RogueTrooper.exe", "type": "Game"}
      { "name": "RTR_x64.exe", "type": "Game"}
      { "name": "Rune.exe", "type": "Game"}
      { "name": "SSVS.exe", "type": "Game"}
      { "name": "Samurai Shodown Collection.exe", "type": "Game"}
      { "name": "Shenmue.exe", "type": "Game"}
      { "name": "Shenmue2.exe", "type": "Game"}
      { "name": "Shenmue3.exe", "type": "Game"}
      { "name": "Shenmue3-Win64-Shipping.exe", "type": "Game"}
      { "name": "Shogo.exe", "type": "Game"}
      { "name": "sin.exe", "type": "Game"}
      { "name": "CoherentUI_Host", "type": "Game" }
      { "name": "sniper5_dx12.exe", "type": "Game"}
      { "name": "sniper5_vulkan.exe", "type": "Game"}
      { "name": "hl2.exe", "type": "Game" }
      { "name": "hammer.exe", "type": "Doc-View" }
      { "name": "hlmv.exe", "type": "Doc-View" }
      { "name": "hl.exe", "type": "Game" }
      { "name": "cstrike.exe", "type": "Game" }
      { "name": "cstrike-online.exe", "type": "Game" }
      { "name": "PortalWars-Linux-Shipping", "type": "Game"}
      { "name": "PortalWars-Win64-Shipping.exe", "type": "Game"}
      { "name": "StarCitizen.exe", "type": "Game" }
      { "name": "soldat.exe", "type": "Game"}
      { "name": "soldat2.exe", "type": "Game"}
      { "name": "XR_3DA.exe", "type": "Game"}
      { "name": "xrEngine.exe", "type": "Game"}
      { "name": "steam", "type": "IN_DIFF" }
      { "name": "steamwebhelper", "type": "BG_CPUIO" }
      { "name": "csgo_linux64", "type": "Game"}
      { "name": "cure_linux", "type": "Game"}
      { "name": "dota2", "type": "Game"}
      { "name": "hl_linux", "type": "Game"}
      { "name": "hl2_linux", "type": "Game"}
      { "name": "ns2_linux", "type": "Game"}
      { "name": "portal2_linux", "type": "Game"}
      { "name": "game.x86_64", "type": "Game"}
      { "name": "game.x86", "type": "Game"}
      { "name": "runner", "type": "Game"}
      { "name": "PA", "type": "Game"}
      { "name": "CoherentUI_Host", "type": "Game"}
      { "name": "Sam3", "type": "Game"}
      { "name": "StarConflict", "type": "Game"}
      { "name": "aces", "type": "Game"}
      { "name": "RocketLeague", "type": "Game"}
      { "name": "ss2013.bin", "type": "Game"}
      { "name": "SaintsRow4.i386", "type": "Game"}
      { "name": "TombRaider", "type": "Game"}
      { "name": "ShadowOfTheTombRaider", "type": "Game"}
      { "name": "Robocraft.x86_64", "type": "Game"}
      { "name": "ShadowWarrior.bin.x86", "type": "Game"}
      { "name": "hoi4", "type": "Game"}
      { "name": "svencoop_linux", "type": "Game"}
      { "name": "Amnesia.bin.x86_64", "type": "Game"}
      { "name": "BaldursGate", "type": "Game"}
      { "name": "BaldursGateII", "type": "Game"}
      { "name": "bms_linux", "type": "Game"}
      { "name": "Butcher", "type": "Game"}
      { "name": "ChildrenOfMorta", "type": "Game"}
      { "name": "CrossCode", "type": "Game"}
      { "name": "EoCApp", "type": "Game"}
      { "name": "Doorways.x86", "type": "Game"}
      { "name": "EtG.x86_64", "type": "Game"}
      { "name": "factorio", "type": "Game"}
      { "name": "GoatGame", "type": "Game"}
      { "name": "GrimFandango", "type": "Game"}
      { "name": "Hatred-Linux-Shipping", "type": "Game"}
      { "name": "HWR", "type": "Game"}
      { "name": "Hotline", "type": "Game"}
      { "name": "HotlineMiami2", "type": "Game"}
      { "name": "HyperLightDrifter", "type": "Game"}
      { "name": "fury.bin", "type": "Game"}
      { "name": "LOF", "type": "Game"}
      { "name": "Mother Russia Bleeds.x86_64", "type": "Game"}
      { "name": "nwmain-linux", "type": "Game"}
      { "name": "OLGame.x86_64", "type": "Game"}
      { "name": "PapersPlease", "type": "Game"}
      { "name": "PartyHardGame.x86_64", "type": "Game"}
      { "name": "Torment", "type": "Game"}
      { "name": "Rakuen.amd64", "type": "Game"}
      { "name": "Sam2017", "type": "Game"}
      { "name": "Shadowgate.x86", "type": "Game"}
      { "name": "Skyborn.amd64", "type": "Game"}
      { "name": "TurokEx", "type": "Game"}
      { "name": "Turok2Ex", "type": "Game"}
      { "name": "wasteland", "type": "Game"}
      { "name": "WL2", "type": "Game"}
      { "name": "AnotherWorld-amd64", "type": "Game"}
      { "name": "Darkwood.x86_64", "type": "Game"}
      { "name": "Disgaea2SteamOS", "type": "Game"}
      { "name": "dontstarve_steam", "type": "Game"}
      { "name": "IcewindDale", "type": "Game"}
      { "name": "postal1", "type": "Game"}
      { "name": "PostalREDUX-Linux-Shipping", "type": "Game"}
      { "name": "starbound", "type": "Game"}
      { "name": "postal2-bin", "type": "Game"}
      { "name": "paradiselost-bin", "type": "Game"}
      { "name": "Dragonfall", "type": "Game"}
      { "name": "SRHK", "type": "Game"}
      { "name": "TheEternalCastle", "type": "Game"}
      { "name": "TheAquaticAdventureOfTheLastHuman", "type": "Game"}
      { "name": "AxiomVerge.bin.x86_64", "type": "Game"}
      { "name": "AxiomVerge.bin.x86", "type": "Game"}
      { "name": "CaveStory+", "type": "Game"}
      { "name": "NecroDancer", "type": "Game"}
      { "name": "ForsakenEx", "type": "Game"}
      { "name": "jng_gold", "type": "Game"}
      { "name": "ShovelKnight", "type": "Game"}
      { "name": "steelstorm64", "type": "Game"}
      { "name": "isaac.i386", "type": "Game"}
      { "name": "isaac.x64", "type": "Game"}
      { "name": "Terraria.bin.x86_64", "type": "Game"}
      { "name": "GiganticArmy.x86", "type": "Game"}
      { "name": "HitmanPro", "type": "Game"}
      { "name": "TheSwapper.bin.x86_64", "type": "Game"}
      { "name": "TheSwapper.bin.x86", "type": "Game"}
      { "name": "Borderlands2", "type": "Game"}
      { "name": "BorderlandsPreSequel", "type": "Game"}
      { "name": "metro", "type": "Game"}
      { "name": "payday2_release", "type": "Game"}
      { "name": "penumbra", "type": "Game"}
      { "name": "blackplague", "type": "Game"}
      { "name": "requiem", "type": "Game"}
      { "name": "pshd", "type": "Game"}
      { "name": "Soma.bin.x86_64", "type": "Game"}
      { "name": "Soma_NoSteam.bin.x86_64", "type": "Game"}
      { "name": "PillarsOfEternity", "type": "Game"}
      { "name": "PillarsOfEternityII", "type": "Game"}
      { "name": "Timespinner", "type": "Game"}
      { "name": "Torchlight2.bin.x86_64", "type": "Game"}
      { "name": "Torchlight2.bin.x86", "type": "Game"}
      { "name": "TidesOfNumenera", "type": "Game"}
      { "name": "trine1_linux_32bit", "type": "Game"}
      { "name": "trine2_linux_32bit", "type": "Game"}
      { "name": "trine3_linux_64bit", "type": "Game"}
      { "name": "Tyranny.x86_64", "type": "Game"}
      { "name": "Tyranny.x86", "type": "Game"}
      { "name": "VVVVVV", "type": "Game"}
      { "name": "witcher2", "type": "Game"}
      { "name": "XCOM2", "type": "Game"}
      { "name": "ArmedSeven.x86", "type": "Game"}
      { "name": "Fahrenheit", "type": "Game"}
      { "name": "LaMulana.bin.x86", "type": "Game"}
      { "name": "SteelStrider.x86", "type": "Game"}
      { "name": "Stardew Valley", "type": "Game"}
      { "name": "Celeste.bin.x86_64", "type": "Game"}
      { "name": "OxygenNotIncluded", "type": "Game"}
      { "name": "PlagueIncEvolved.x86_64", "type": "Game"}
      { "name": "Figment.x86", "type": "Game"}
      { "name": "Figment.x86_64", "type": "Game"}
      { "name": "oneshot", "type": "Game"}
      { "name": "McEngine", "type": "Game"}
      { "name": "supertuxkart", "type": "Game"}
      { "name": "Troy.exe", "type": "Game"}
      { "name": "THIEF.EXE", "type": "Game"}
      { "name": "THIEF_no_ddfix.EXE", "type": "Game"}
      { "name": "Shipping-ThiefGame.exe", "type": "Game"}
      { "name": "thief2.exe", "type": "Game"}
      { "name": "thief2_no_ddfix.exe", "type": "Game"}
      { "name": "Thief2.exe", "type": "Game"}
      { "name": "t3.exe", "type": "Game"}
      { "name": "T3Main.exe", "type": "Game"}
      { "name": "TheMatriarch.exe", "type": "Game" }
      { "name": "TheMatriarch-Win64-Shipping.exe", "type": "Game" }
      { "name": "eso64.exe", "type": "Game"}
      { "name": "SS2.exe", "type": "Game"}
      { "name": "TotalA.exe", "type": "Game"}
      { "name": "TAE.EXE", "type": "Game"}
      { "name": "Tower-Win64-Shipping.exe", "type": "Game"}
      { "name": "UE4Editor", "type": "BG_CPUIO" }
      { "name": "ShaderCompileWorker", "type": "BG_CPUIO" }
      { "name": "UnrealLightmass", "type": "BG_CPUIO" }
      { "name": "UnrealPak", "type": "BG_CPUIO" }
      { "name": "Trackmania.exe", "type": "Game" }# www.oldunreal.com
      { "name": "UnrealLinux.bin", "type": "Game"}
      { "name": "ut-bin", "type": "Game"}
      { "name": "ut-bin-x86", "type": "Game"}
      { "name": "Unturned.x86_64", "type": "Game"}
      { "name": "underrail.exe", "type": "Game"}
      { "name": "upc.exe", "type": "BG_CPUIO"}
      { "name": "UbisoftGameLaun", "type": "BG_CPUIO"}
      { "name": "UplayWebCore.ex", "type": "BG_CPUIO"}
      { "name": "UT2004.exe", "type": "Game" }
      { "name": "WarGame2.exe", "type": "Game"}
      { "name": "vampire.exe", "type": "Game"}
      { "name": "Vampire.exe", "type": "Game"}
      { "name": "Warframe.x64.exe", "type": "Game" }
      { "name": "VampireSurvivors.exe", "type": "Game" }
      { "name": "WarGame3.exe", "type": "Game"}
      { "name": "Watch_Dogs.exe", "type": "Game"}
      { "name": "ecwolf", "type": "Game"}
      { "name": "WatchDogs2.exe", "type": "Game"}
      { "name": "wineserver", "nice": 19, "sched": "fifo" }
      { "name": "WoWSLauncher.exe", "type": "BG_CPUIO" }
      { "name": "worldofwarships", "type": "Game" }
      { "name": "witcher.exe", "type": "Game"}
      { "name": "witcher2.exe", "type": "Game"}
      { "name": "witcher3.exe", "type": "Game"}
      { "name": "wrath.exe", "type": "Game"}
      { "name": "wrath-sdl.exe", "type": "Game"}
      { "name": "gerbera", "type": "BG_CPUIO" }# Xonotic https://www.xonotic.org/
      { "name": "xonotic-glx", "type": "Game"}
      { "name": "xonotic-sdl", "type": "Game"}
      { "name": "ys8.exe", "type": "Game"}
      { "name": "Ysc_dx11.exe", "type": "Game"}
      { "name": "Ys7.exe", "type": "Game"}
      { "name": "yso_win.exe", "type": "Game"}
      { "name": "ys1plus.exe", "type": "Game"}
      { "name": "ysf_win.exe", "type": "Game"}
      { "name": "ysf_win_dx9.exe", "type": "Game"}
      { "name": "ys6_win.exe", "type": "Game"}
      { "name": "ys6_win_dx9.exe", "type": "Game"}
      { "name": "gimp", "type": "LowLatency_RT", "nice": -10, "ioclass": "realtime" }
      { "name": "guake", "type": "Doc-View" }
      { "name": "gitkraken", "type":"Doc-View" }
      { "name": "R", "type": "BG_CPUIO" }
      { "name": "Torchlight.exe", "type": "Game"}
      { "name": "Torchlight2.exe", "type": "Game"}
      { "name": "Frontiers.exe", "type": "Game"}
      { "name": "Frontiers-Win64-Shipping.exe", "type": "Game"}
      { "name": "higan", "type": "Game"}
      { "name": "kbfsfuse", "type": "BG_CPUIO"}
      { "name": "insync", "type": "BG_CPUIO" }
      { "name": "ghb", "type": "BG_CPUIO" }
      { "name": "glhexen2", "type": "Game"}
      { "name": "hexen2", "type": "Game"}
      { "name": "glhwcl", "type": "Game"}
      { "name": "hwcl", "type": "Game"}
      { "name": "cmake", "type": "compiler" }
      { "name": "kdeconnectd", "type": "BG_CPUIO" }
      { "name": "kdeconnect-indicator", "type": "BG_CPUIO" }
      { "name": "kget", "type": "BG_CPUIO" }
      { "name": "keepassxc", "type":"Doc-View" }# Double Commander file browser: https://doublecmd.sourceforge.io/
      { "name": "doublecmd", "type": "Doc-View" }
      { "name": "KSP.x86_64", "type": "Game"}
      { "name": "ktorrent", "type": "BG_CPUIO" }
      { "name": "lightdm", "ioclass" : "realtime", "ionice" : 4}
      { "name": "kupfer", "type": "BG_CPUIO" }
      { "name": "oosplash", "type": "Doc-View" }
      { "name": "soffice.bin", "type": "Doc-View" }
      { "name": "linphon", "type" : "LowLatency_RT", "nice" : -15, "ioclass" : "realtime" }
      { "name": "alephone", "type": "Game"}
      { "name": "mame", "type": "Game"}
      { "name": "sdlmame", "type": "Game"}
      { "name": "mednafen", "type": "Game"}
      { "name": "mc", "type": "Doc-View" }
      { "name": "mirage", "type": "Image-View" }
      { "name": "mesen", "type": "Game"}
      { "name": "mesen-git", "type": "Game"}
      { "name": "melt", "type": "BG_CPUIO" }
      { "name": "megasync", "type": "BG_CPUIO" }
      { "name": "mixxx", "type": "LowLatency_RT" }
      { "name": "mpv", "type": "Player-Video" }
      { "name": "mpd", "type": "Player-Audio" }
      { "name": "mochi", "type": "Doc-View" }
      { "name": "ncmcpp", "type": "Player-Audio" }
      { "name": "mplayer", "type": "Player-Video" }
      { "name": "nix", "type": "BG_CPUIO" }
      { "name": "nix-daemon", "type": "BG_CPUIO" }
      { "name": "nix-store", "type": "BG_CPUIO" }
      { "name": "nextcloud", "type": "BG_CPUIO" }
      { "name": "nvdock", "type": "BG_CPUIO" }
      { "name": "onedrive", "type": "BG_CPUIO" }{ "name": "DesktopEditors", "type": "Doc-View" }
      { "name": "node", "type": "BG_CPUIO"}
      { "name": "owncloud", "type": "BG_CPUIO" }
      { "name": "PPSSPPSDL", "type": "Game"}
      { "name": "PPSSPPHeadless", "type": "Game"}
      { "name": "PPSSPPQt", "type": "Game"}
      { "name": "plexmediaplayer", "type": "Player-Video" }
      { "name": "psensor", "type": "BG_CPUIO" }
      { "name": "qbittorrent", "type": "BG_CPUIO" }
      { "name": "qbittorrent-nox", "type": "BG_CPUIO" }
      { "name": "parsecd", "type": "LowLatency_RT" }
      { "name": "qmmp", "type": "Player-Audio" }
      { "name": "plank", "type": "BG_CPUIO" }
      { "name": "qimgv", "type": "Image-View" }
      { "name": "recollindex", "type": "BG_CPUIO" }
      { "name": "redshift", "type": "BG_CPUIO" }
      { "name": "openrct2", "type": "Game"}
      { "name": "rclone", "type": "BG_CPUIO" }
      { "name": "quiterss", "type": "Doc-View" }
      { "name": "remote-viewer", "type": "LowLatency_RT" }
      { "name": "restic", "type": "BG_CPUIO"}
      { "name": "rhythmbox", "type": "Player-Audio" }
      { "name": "rstudio", "type": "LowLatency_RT" }
      { "name": "rsession", "type": "BG_CPUIO" }
      { "name": "rott", "type": "Game"}
      { "name": "rottexpr", "type": "Game"}
      { "name": "rott-registered", "type": "Game"}
      { "name": "rott-shareware", "type": "Game"}
      { "name": "rtorrent", "type": "BG_CPUIO" }
      { "name": "SABnzbd.py", "type": "BG_CPUIO" }# Play Station 3 emulator: https://rpcs3.net
      { "name": "rpcs3", "type": "Game"}
      { "name": "rsync", "type": "BG_CPUIO" }
      { "name": "iowolfmp.x86_64", "type": "Game"}
      { "name": "iowolfsp.x86_64", "type": "Game"}
      { "name": "iortcw-mp", "type": "Game"}
      { "name": "iortcw-sp", "type": "Game"}
      { "name": "shotwell", "type": "Image-View" }
      { "name": "soundkonverter", "type": "Heavy_CPU" }
      { "name": "sopcast-player", "type": "Player-Video" }
      { "name": "sopcast-player.py", "type": "Player-Video" }
      { "name": "shutter", "type": "Image-View" }
      { "name": "smplayer", "type": "Player-Video" }
      { "name": "smbd", "type": "LowLatency_RT" }#Stremio is a modern media center that gives you the freedom to watch everything you want. https://www.stremio.com/
      { "name": "stremio", "type": "Player-Video" }
      { "name": "freesynd", "type": "Game"}
      { "name": "atom", "type": "Doc-View" }
      { "name": "pulsar, "type": "Doc-View" }
      { "name": "codium", "type": "Doc-View" }
      { "name": "code", "type": "Doc-View" }
      { "name": "code.js", "type": "Doc-View" }
      { "name": "micro", "type": "Doc-View" }
      { "name": "vim", "type": "Doc-View" }
      { "name": "nvim", "type": "Doc-View" }
      { "name": "lapce", "type": "Doc-View" }
      { "name": "sublime_merge", "type":"Doc-View" }
      { "name": "sublime-text", "type": "Doc-View" }
      { "name": "subl3", "type": "Doc-View" }
      { "name": "sublime_text", "type": "Doc-View" }
      { "name": "plugin_host", "type": "Doc-View" }
      { "name": "nano", "type": "Doc-View" }
      { "name": "kate", "type": "Doc-View" }
      { "name": "emacs", "type": "Doc-View" }
      { "name": "emacsclient", "type": "Doc-View" }
      { "name": "kak", "type": "Doc-View" }
      { "name": "hx", "type": "Doc-View" }
      { "name": "syncthing", "type": "BG_CPUIO" }
      { "name": "syncthing-gtk", "type": "BG_CPUIO" }# Idle management daemon for Wayland
      { "name": "swayidle", "type": "BG_CPUIO" }
      { "name": "soulseekqt", "type":"Doc-View" }
      { "name": "tixati", "type": "BG_CPUIO" }
      { "name": "thrash-protect", "nice": -12, "ioclass": "realtime" }
      { "name": "tmux", "type": "Doc-View" }
      { "name": "tilix", "type": "Doc-View" }
      { "name": "7z", "type": "BG_CPUIO"}
      { "name": "btop", "type": "BG_CPUIO" }
      { "name": "systemd-timesyncd", "type": "BG_CPUIO" }
      { "name": "systemd-resolved", "type": "BG_CPUIO" }# curl - URL retrieval utility and library: https://curl.haxx.se
      { "name": "curl", "type": "BG_CPUIO" }
      { "name": "corectrl_helper", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "corectrl", "type" : "BG_CPUIO"}
      { "name": "cupsd", "type": "BG_CPUIO" }
      { "name": "cups-browsed", "type": "BG_CPUIO" }
      { "name": "nextdns", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "htop", "type": "BG_CPUIO" }
      { "name": "copilot-agent-linux", "type": "BG_CPUIO" }
      { "name": "dbus-daemon", "type": "Service" }
      { "name": "qemu-system-x86_64", "type": "Heavy_CPU" }
      { "name": "qemu-system-x86", "type": "Heavy_CPU" }
      { "name": "meld", "type": "BG_CPUIO" }
      { "name": "unison", "type": "BG_CPUIO" }# Torrent client: https://www.transmissionbt.com
      { "name": "transgui",            "type": "BG_CPUIO" }
      { "name": "transmission-cli",    "type": "BG_CPUIO" }
      { "name": "transmission-daemon", "type": "BG_CPUIO" }
      { "name": "transmission-gtk",    "type": "BG_CPUIO" }
      { "name": "transmission-qt",     "type": "BG_CPUIO" }
      { "name": "transmission-remote", "type": "BG_CPUIO" }
      { "name": "smartgit", "type":"Doc-View" }
      { "name": "tor", "type": "Service" }
      { "name": "ssh-agent", "type": "BG_CPUIO" }
      { "name": "wget", "type": "BG_CPUIO" }
      { "name": "thermald", "type": "BG_CPUIO" }
      { "name": "smartd", "type": "BG_CPUIO" }
      { "name": "totem", "type": "Player-Video" }
      { "name": "uptimed", "type": "BG_CPUIO" }
      { "name": "vmware-vmx", "type": "Heavy_CPU" }
      { "name": "vmware", "type": "Heavy_CPU" }
      { "name": "waybar", "type": "LowLatency_RT" }
      { "name": "wlsunset", "type": "BG_CPUIO" }
      { "name": "wayst", "type": "Doc-View" }
      { "name": "weston", "type": "LowLatency_RT" }
      { "name": "yuzu", "type": "Game"}
      { "name": "xarchiver", "type": "BG_CPUIO"}
      { "name": "okular", "type": "Doc-View" }# https://krita.org
      { "name": "krita", "type": "LowLatency_RT" }
      { "name": "FactoryGame.exe", "type": "Game"}
      { "name": "FactoryGame-Win64-Shipping.exe", "type": "Game"}
      { "name": "mednaffe", "type": "BG_CPUIO" }
      { "name": "inkscape", "type": "LowLatency_RT" }
      { "name": "QtWebEngineProcess", "type": "Player-Video" }
      { "name": "vlc", "type": "Player-Video" }
      { "name": "gammastep", "type": "BG_CPUIO" }
      { "name": "spotify", "type": "Player-Audio" }
      { "name": "TESV.exe", "type": "Game"}
      { "name": "SkyrimSE.exe", "type": "Game"}
      { "name": "stellaris", "type": "Game" }
      { "name": "pipewire", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "wireplumber", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "pulseaudio", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "youtube-dl", "type": "BG_CPUIO" }
      { "name": "yt-dlp", "type": "BG_CPUIO" }
      { "name": "audacious", "type": "Player-Audio" }
      { "name": "audacity", "type": "LowLatency_RT" }
      { "name": "xviewer", "type": "Doc-View" }
      { "name": "brave", "type": "Doc-View" }
      { "name": "brave-bin", "type": "Doc-View" }
      { "name": "/usr/lib/brave-bin/brave", "type": "Doc-View" }
      { "name": "brave-browser", "type": "Doc-View" }
      { "name": "brave-sandbox", "type": "Doc-View" }
      { "name": "nacl_helper", "type": "Doc-View" }
      { "name": "chrome-sandbox", "type": "Doc-View" }
      { "name": "chromium-snapshot", "type": "Doc-View" }
      { "name": "chromium-snapshot-bin", "type": "Doc-View" }
      { "name": "chromium", "type": "Doc-View" }
      { "name": "thorium", "type": "Doc-View" }
      { "name": "thorium-browser-unstable", "type": "Doc-View" }
      { "name": "thorium-shell", "type": "Doc-View" }
      { "name": "vivaldi-bin", "type": "Doc-View" }
      { "name": "firefox", "type":"Doc-View" }
      { "name": "firefox-bin", "type":"Doc-View" }
      { "name": "firefox-esr", "type":"Doc-View" }
      { "name": "firefox.real", "type":"Doc-View" }
      { "name": "icecat", "type":"Doc-View" }
      { "name": "firefox-nightly", "type":"Doc-View" }
      { "name": "firefox-developer-edition", "type":"Doc-View" }
      { "name": "librewolf", "type":"Doc-View" }
      { "name": "librewolf-bin", "type":"Doc-View" }
      { "name": "librewolf-nightly", "type":"Doc-View" }
      { "name": "firedragon", "type":"Doc-View" }
      { "name": "firedragon-bin", "type":"Doc-View" }
      { "name": "cachy-browser", "type":"Doc-View" }
      { "name": "chrome", "type": "Doc-View" }
      { "name": "nacl_helper", "type": "Doc-View" }
      { "name": "chrome-sandbox", "type": "Doc-View" }
      { "name": "google-chrome-dev", "type": "Doc-View" }
      { "name": "google-chrome-unstable", "type": "Doc-View" }
      { "name": "waterfox-g", "type": "Doc-View" }
      { "name": "rsync", "type": "BG_CPUIO" }
      { "name": "rmlint", "type": "BG_CPUIO" }
      { "name": "zoom", "type": "Chat" }
      { "name": "weechat", "type": "Chat" }
      { "name": "viber", "type":"Chat" }
      { "name": "telegram-desktop", "type": "Chat" }
      { "name": "telegram-desktop.bin", "type": "Chat" }
      { "name": "Telegram", "type": "Chat" }
      { "name": "telegram", "type": "Chat" }
      { "name": "Discord", "type": "Chat" }
      { "name": "DiscordPTB", "type": "Chat" }
      { "name": "DiscordCanary", "type": "Chat" }
      { "name": "DiscordDevelopment", "type": "chat" }
      { "name": "webcord", "type": "Chat" }
      { "name": "armcord", "type": "Chat" }
      { "name": "hexchat", "type": "Chat" }
      { "name": "teams", "type": "Chat" }
      { "name": "kotatogram-desktop", "type": "Chat" }
      { "name": "kotatogram-desktop.bin", "type": "Chat" }
      { "name": "vk", "type":"Chat" }
      { "name": "signal-desktop", "type": "Chat" }
      { "name": "signal-desktop-beta", "type": "Chat" }
      { "name": "skypeforlinux", "type": "Chat" }
      { "name": "slack", "type":"Chat" }
      { "name": "rambox", "type": "Chat" }
      { "name": "qtox", "type": "Chat" }
      { "name": "caprine", "type": "Chat" }
      { "name": "mailspring", "type": "Chat" }
      { "name": "thunderbird", "type": "Chat" }
      { "name": "franz", "type": "Chat" }
      { "name": "ferdi", "type": "Chat" }
      { "name": "ferdium", "type": "Chat" }
    '';
  };
}
