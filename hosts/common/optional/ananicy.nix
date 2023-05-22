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
      { "type": "Game", "nice": -7, "ioclass": "best-effort", "latency_nice": -7 }
      { "type": "Player-Audio", "nice": -4, "latency_nice": -4 }
      { "type": "Player-Video", "nice": -4, "latency_nice": -4 }
      { "type": "Image-View", "nice": -4, "latency_nice": -4 }
      { "type": "Doc-View",   "nice": -4, "latency_nice": -4 }
      { "type": "LowLatency_RT", "nice": -9, "ioclass": "best-effort", "latency_nice": -9 }
      { "type": "BG_CPUIO", "nice": 16, "ioclass": "idle", "sched": "idle", "latency_nice": 11 }
      { "type": "Heavy_CPU", "nice": 9, "ioclass": "best-effort", "ionice": 7, "latency_nice": 9 }
      { "type": "VFIO", "nice": -10, "latency_nice": -20 }
      { "type": "Chat", "nice": -3, "ioclass": "best-effort", "ionice": 7 , "latency_nice": -3 }
      { "type":"compiler", "nice": 9, "latency_nice": 9 }
      { "type": "Service", "nice": 10, "ioclass": "best-effort", "ionice": 6 , "latency_nice": 10 }
      { "type": "IN_DIFF", "nice": 0, "ioclass": "best-effort", "ionice": 7 , "latency_nice": 0 }
      { "type": "OOM_KILL", "oom_score_adj": 1000 }
      { "type": "OOM_NO_KILL", "oom_score_adj": -1000 }

      { "cgroup": "cpu90", "CPUQuota": 90 }
      { "cgroup": "cpu85", "CPUQuota": 85 }
      { "cgroup": "cpu80", "CPUQuota": 80 }

      { "name": "0ad", "type": "Game" }
      { "name": "7z", "type": "BG_CPUIO"}
      { "name": "AnotherWorld-amd64", "type": "Game"}
      { "name": "ArchiSteamFarm", "type": "BG_CPUIO" }
      { "name": "BaldursGate", "type": "Game"}
      { "name": "BaldursGateII", "type": "Game"}
      { "name": "BeyondTwoSouls_", "type": "Game"}
      { "name": "BitwigStudioEngine", "type": "LowLatency_RT" }
      { "name": "Borderlands2", "type": "Game"}
      { "name": "BorderlandsPreSequel", "type": "Game"}
      { "name": "Butcher", "type": "Game"}
      { "name": "CaveStory+", "type": "Game"}
      { "name": "ChildrenOfMorta", "type": "Game"}
      { "name": "CoherentUI_Host", "type": "Game" }
      { "name": "CoherentUI_Host", "type": "Game"}
      { "name": "CrossCode", "type": "Game"}
      { "name": "DesktopEditors", "type": "Doc-View" }
      { "name": "DetroitBecomeHu", "type": "Game"}
      { "name": "Discord", "type": "Chat" }
      { "name": "DiscordCanary", "type": "Chat" }
      { "name": "DiscordDevelopment", "type": "chat" }
      { "name": "DiscordPTB", "type": "Chat" }
      { "name": "Disgaea2SteamOS", "type": "Game"}
      { "name": "DisplayLinkManager", "type": "LowLatency_RT" }
      { "name": "Dragonfall", "type": "Game"}
      { "name": "EoCApp", "type": "Game"}
      { "name": "FAHClient", "type": "Heavy_CPU" }
      { "name": "Fahrenheit", "type": "Game"}
      { "name": "ForsakenEx", "type": "Game"}
      { "name": "FoxitReader", "type": "Doc-View" }
      { "name": "GOTHIC.EXE", "type": "Game"}
      { "name": "GoatGame", "type": "Game"}
      { "name": "GrimFandango", "type": "Game"}
      { "name": "HWR", "type": "Game"}
      { "name": "Hatred-Linux-Shipping", "type": "Game"}
      { "name": "Hitman.Exe", "type": "Game"}
      { "name": "HitmanPro", "type": "Game"}
      { "name": "Hotline", "type": "Game"}
      { "name": "HotlineMiami2", "type": "Game"}
      { "name": "HyperLightDrifter", "type": "Game"}
      { "name": "Hyprland", "type": "LowLatency_RT" }
      { "name": "IcewindDale", "type": "Game"}
      { "name": "LOF", "type": "Game"}
      { "name": "McEngine", "type": "Game"}
      { "name": "NecroDancer", "type": "Game"}
      { "name": "OxygenNotIncluded", "type": "Game"}
      { "name": "PA", "type": "Game"}
      { "name": "PKHDGame-Win32-Shipping.ex", "type": "Game"}
      { "name": "PPSSPPHeadless", "type": "Game"}
      { "name": "PPSSPPQt", "type": "Game"}
      { "name": "PPSSPPSDL", "type": "Game"}
      { "name": "PapersPlease", "type": "Game"}
      { "name": "PillarsOfEternity", "type": "Game"}
      { "name": "PillarsOfEternityII", "type": "Game"}
      { "name": "PortalWars-Linux-Shipping", "type": "Game"}
      { "name": "PostalREDUX-Linux-Shipping", "type": "Game"}
      { "name": "QtWebEngineProcess", "type": "Player-Video" }
      { "name": "R", "type": "BG_CPUIO" }
      { "name": "Rakuen.amd64", "type": "Game"}
      { "name": "Redprelauncher", "type": "game-launcher"}
      { "name": "RimWorldLinux", "type": "Game" }
      { "name": "RocketLeague", "type": "Game"}
      { "name": "SABnzbd.py", "type": "BG_CPUIO" }
      { "name": "SRHK", "type": "Game"}
      { "name": "SVPManager", "type": "Player-Video" }
      { "name": "SaintsRow4.i386", "type": "Game"}
      { "name": "Sam2017", "type": "Game"}
      { "name": "Sam3", "type": "Game"}
      { "name": "ShaderCompileWorker", "type": "BG_CPUIO" }
      { "name": "ShadowOfTheTombRaider", "type": "Game"}
      { "name": "ShovelKnight", "type": "Game"}
      { "name": "Skyborn.amd64", "type": "Game"}
      { "name": "StarConflict", "type": "Game"}
      { "name": "Stardew Valley", "type": "Game"}
      { "name": "TAE.EXE", "type": "Game"}
      { "name": "THIEF.EXE", "type": "Game"}
      { "name": "THIEF_no_ddfix.EXE", "type": "Game"}
      { "name": "Telegram", "type": "Chat" }
      { "name": "TheAquaticAdventureOfTheLastHuman", "type": "Game"}
      { "name": "TheEternalCastle", "type": "Game"}
      { "name": "TidesOfNumenera", "type": "Game"}
      { "name": "Timespinner", "type": "Game"}
      { "name": "TombRaider", "type": "Game"}
      { "name": "Torment", "type": "Game"}
      { "name": "Turok2Ex", "type": "Game"}
      { "name": "TurokEx", "type": "Game"}
      { "name": "UE4Editor", "type": "BG_CPUIO" }
      { "name": "UbisoftGameLaun", "type": "BG_CPUIO"}
      { "name": "Universe", "type": "Game"}
      { "name": "UnrealLightmass", "type": "BG_CPUIO" }
      { "name": "UnrealLinux.bin", "type": "Game"}
      { "name": "UnrealPak", "type": "BG_CPUIO" }
      { "name": "UplayWebCore.ex", "type": "BG_CPUIO"}
      { "name": "VVVVVV", "type": "Game"}
      { "name": "WL2", "type": "Game"}
      { "name": "XCOM2", "type": "Game"}
      { "name": "Xorg", "nice" : -12, "ionice" : 1, "latency_nice" : -10 }
      { "name": "Xwayland", "type": "LowLatency_RT"}
      { "name": "aces", "type": "Game"}
      { "name": "acestream-launcher", "type": "Player-Video" }
      { "name": "acestream-player",   "type": "Player-Video" }
      { "name": "acestreamengine",    "type": "Player-Video" }
      { "name": "alacritty", "type": "Doc-View" }
      { "name": "alarm-clock", "type": "BG_CPUIO" }
      { "name": "alephone", "type": "Game"}
      { "name": "amule", "type": "BG_CPUIO" }
      { "name": "android-studio", "type": "Heavy_CPU" }
      { "name": "aria2c", "type": "BG_CPUIO" }
      { "name": "ario", "type": "Player-Audio" }
      { "name": "ark", "type": "BG_CPUIO"}
      { "name": "armcord", "type": "Chat" }
      { "name": "atom", "type": "Doc-View" }
      { "name": "audacious", "type": "Player-Audio" }
      { "name": "audacity", "type": "LowLatency_RT" }
      { "name": "avd", "type": "Heavy_CPU"
      { "name": "awesome", "type": "LowLatency_RT" }
      { "name": "baloo_file", "type": "BG_CPUIO" }
      { "name": "bees", "type": "BG_CPUIO", "oom_score_adj": 1000 }
      { "name": "bitwig-studio",      "type": "LowLatency_RT" }
      { "name": "blackplague", "type": "Game"}
      { "name": "blastem", "type": "Game"}
      { "name": "blender", "type": "LowLatency_RT", "nice": -10, "ioclass": "realtime" }
      { "name": "blueberry-tray", "type": "BG_CPUIO" }
      { "name": "blueman-applet", "type": "BG_CPUIO" }
      { "name": "bms_linux", "type": "Game"}
      { "name": "boinc", "type": "Heavy_CPU" }
      { "name": "borg", "type": "BG_CPUIO"
      { "name": "brave", "type": "Doc-View" }
      { "name": "brave-bin", "type": "Doc-View" }
      { "name": "brave-browser", "type": "Doc-View" }
      { "name": "brave-sandbox", "type": "Doc-View" }
      { "name": "bspwm", "type": "LowLatency_RT" }
      { "name": "btop", "type": "BG_CPUIO" }
      { "name": "cachy-browser", "type":"Doc-View" }
      { "name": "calibre", "type": "Doc-View" }
      { "name": "caprine", "type": "Chat" }
      { "name": "cargo", "type": "compiler" }
      { "name": "celluloid", "type": "Player-Video" }
      { "name": "cen64", "type": "Game"}
      { "name": "cen64-qt", "type": "Game"}
      { "name": "chocolate-doom", "type": "Game"}
      { "name": "chrome", "type": "Doc-View" }
      { "name": "chrome-sandbox", "type": "Doc-View" }
      { "name": "chrome-sandbox", "type": "Doc-View" }
      { "name": "chromium", "type": "Doc-View" }
      { "name": "chromium-snapshot", "type": "Doc-View" }
      { "name": "chromium-snapshot-bin", "type": "Doc-View" }
      { "name": "clamd", "type": "BG_CPUIO" }
      { "name": "clang", "type": "compiler" }
      { "name": "clang++", "type": "compiler" }
      { "name": "clang-tidy", "type": "BG_CPUIO" }
      { "name": "clementine", "type": "Player-Audio" }
      { "name": "clementine-tagreader", "type": "Player-Audio" }
      { "name": "cmake", "type": "compiler" }
      { "name": "cmus", "type": "Player-Audio" }
      { "name": "code", "type": "Doc-View" }
      { "name": "code.js", "type": "Doc-View" }
      { "name": "codium", "type": "Doc-View" }
      { "name": "collectd", "type": "BG_CPUIO" }
      { "name": "com.github.tkashkin.gamehub", "type": "BG_CPUIO" }
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "compton", "type": "LowLatency_RT" }
      { "name": "copilot-agent-linux", "type": "BG_CPUIO" }
      { "name": "corectrl", "type" : "BG_CPUIO"}
      { "name": "corectrl_helper", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "coredns", "type": "LowLatency_RT" }
      { "name": "csgo_linux64", "type": "Game"}
      { "name": "cups-browsed", "type": "BG_CPUIO" }
      { "name": "cupsd", "type": "BG_CPUIO" }
      { "name": "cure_linux", "type": "Game"}
      { "name": "curl", "type": "BG_CPUIO" }
      { "name": "d1x-rebirth", "type": "Game"}
      { "name": "d2x-rebirth", "type": "Game"}
      { "name": "dbus-daemon", "type": "Service" }
      { "name": "deadbeef-gtkui", "type": "Player-Audio" }
      { "name": "deluge",  "type": "BG_CPUIO" }
      { "name": "deluged", "type": "BG_CPUIO" }
      { "name": "devilutionx", "type": "Game"}
      { "name": "dhewm3", "type": "Game"}
      { "name": "dnsmasq", "type": "Doc-View" }
      { "name": "dolphin-emu", "type": "Game"}
      { "name": "dontstarve_steam", "type": "Game"}
      { "name": "dota2", "type": "Game"}
      { "name": "doublecmd", "type": "Doc-View" }
      { "name": "dropbox", "type": "BG_CPUIO" }
      { "name": "dupeguru", "type": "Heavy_CPU" }
      { "name": "duperemove", "type": "BG_CPUIO" }
      { "name": "ebook-viewer", "type": "Doc-View" }
      { "name": "ecwolf", "type": "Game"}
      { "name": "eduke32", "type": "Game"}
      { "name": "emacs", "type": "Doc-View" }
      { "name": "emacsclient", "type": "Doc-View" }
      { "name": "eog", "type": "Image-View" }
      { "name": "et", "type": "Game"}
      { "name": "etcd", "type": "LowLatency_RT", "nice": -10, "ioclass": "realtime" }
      { "name": "etl", "type": "Game"}
      { "name": "evince", "type": "Doc-View" }
      { "name": "factorio", "type": "Game"}
      { "name": "fail2ban-server", "type": "BG_CPUIO" }
      { "name": "fdupes", "type": "BG_CPUIO" }
      { "name": "feh", "type": "Image-View" }
      { "name": "ferdi", "type": "Chat" }
      { "name": "ferdium", "type": "Chat" }
      { "name": "ffmpeg", "type": "LowLatency_RT" }
      { "name": "file-roller", "type": "BG_CPUIO" }
      { "name": "firedragon", "type":"Doc-View" }
      { "name": "firedragon-bin", "type":"Doc-View" }
      { "name": "firefox", "type":"Doc-View" }
      { "name": "firefox-bin", "type":"Doc-View" }
      { "name": "firefox-developer-edition", "type":"Doc-View" }
      { "name": "firefox-esr", "type":"Doc-View" }
      { "name": "firefox-nightly", "type":"Doc-View" }
      { "name": "firefox.real", "type":"Doc-View" }
      { "name": "flutter", "type": "Heavy_CPU" }
      { "name": "fluxbox", "type": "LowLatency_RT" }
      { "name": "foot", "type": "Doc-View" }
      { "name": "footclient", "type": "Doc-View" }
      { "name": "fossilize_replay", "type": "BG_CPUIO"}
      { "name": "franz", "type": "Chat" }
      { "name": "freesynd", "type": "Game"}
      { "name": "fs-uae", "type": "Game"}
      { "name": "fs-uae-devel", "type": "Game"}
      { "name": "fury.bin", "type": "Game"}
      { "name": "g++", "type": "compiler" }
      { "name": "gammastep", "type": "BG_CPUIO" }
      { "name": "gcc", "type": "compiler" }
      { "name": "gdm", "type": "LowLatency_RT"}
      { "name": "gdm-session-worker", "type": "Service"}
      { "name": "gdm-wayland-session", "type": "LowLatency_RT"
      { "name": "gerbera", "type": "BG_CPUIO" }
      { "name": "ghb", "type": "BG_CPUIO" }
      { "name": "gimp", "type": "LowLatency_RT", "nice": -10, "ioclass": "realtime" }
      { "name": "gitkraken", "type":"Doc-View" }
      { "name": "glhexen2", "type": "Game"}
      { "name": "glhwcl", "type": "Game"}
      { "name": "gmod", "type": "Game"}
      { "name": "gnome-keyring-daemon", "type": "Service"}
      { "name": "gnome-terminal-server", "type": "Doc-View" }
      { "name": "go", "type": "compiler" }
      { "name": "gogdl", "type": "BG_CPUIO" }
      { "name": "google-chrome-dev", "type": "Doc-View" }
      { "name": "google-chrome-unstable", "type": "Doc-View" }
      { "name": "guake", "type": "Doc-View" }
      { "name": "gzdoom", "type": "Game"}
      { "name": "heroic", "type": "Doc-View" }
      { "name": "hexchat", "type": "Chat" }
      { "name": "hexen2", "type": "Game"}
      { "name": "higan", "type": "Game"}
      { "name": "hl2_linux", "type": "Game"}
      { "name": "hl_linux", "type": "Game"}
      { "name": "hoi4", "type": "Game"}
      { "name": "hoi4", "type": "Game"}
      { "name": "htop", "type": "BG_CPUIO" }
      { "name": "hwcl", "type": "Game"}
      { "name": "hx", "type": "Doc-View" }
      { "name": "hyper", "type": "Doc-View" }
      { "name": "i3", "type": "LowLatency_RT" }
      { "name": "icecat", "type":"Doc-View" }
      { "name": "inkscape", "type": "LowLatency_RT" }
      { "name": "insurgency_linux", "type": "Game"}
      { "name": "insync", "type": "BG_CPUIO" }
      { "name": "ioquake3", "type": "Game"}
      { "name": "iortcw-mp", "type": "Game"}
      { "name": "iortcw-sp", "type": "Game"}
      { "name": "isaac.i386", "type": "Game"}
      { "name": "jellyfin", "type": "Heavy_CPU" }
      { "name": "jng_gold", "type": "Game"}
      { "name": "kak", "type": "Doc-View" }
      { "name": "kate", "type": "Doc-View" }
      { "name": "kbfsfuse", "type": "BG_CPUIO"}
      { "name": "kdeconnect-indicator", "type": "BG_CPUIO" }
      { "name": "kdeconnectd",  "type": "BG_CPUIO" }
      { "name": "kdeconnectd", "type": "BG_CPUIO" }
      { "name": "keepassxc", "type":"Doc-View" }
      { "name": "kget", "type": "BG_CPUIO" }
      { "name": "kitty", "type": "Doc-View" }
      { "name": "konsole", "type": "Doc-View" }
      { "name": "kotatogram-desktop", "type": "Chat" }
      { "name": "kotatogram-desktop.bin", "type": "Chat" }
      { "name": "krita", "type": "LowLatency_RT" }
      { "name": "krunner", "type": "LowLatency_RT" }
      { "name": "ktorrent", "type": "BG_CPUIO" }
      { "name": "kube-apiserver", "type": "Heavy_CPU" }
      { "name": "kube-controller-manager", "type": "Heavy_CPU" }
      { "name": "kube-proxy", "type": "Heavy_CPU" }
      { "name": "kube-scheduler", "type": "Heavy_CPU" }
      { "name": "kupfer", "type": "BG_CPUIO" }
      { "name": "kwin_wayland", "type": "LowLatency_RT"}
      { "name": "kwin_wayland_wrapper", "type": "LowLatency_RT"}
      { "name": "kwin_x11", "type": "LowLatency_RT" }
      { "name": "lapce", "type": "Doc-View" }
      { "name": "ld", "type": "compiler" }
      { "name": "ld.bfd", "type": "compiler" }
      { "name": "ld.lld", "type": "compiler" }
      { "name": "ld.mold", "type": "compiler" }
      { "name": "legendary", "type": "IN_DIFF" }
      { "name": "librewolf", "type":"Doc-View" }
      { "name": "librewolf-bin", "type":"Doc-View" }
      { "name": "librewolf-nightly", "type":"Doc-View" }
      { "name": "lightdm", "ioclass" : "realtime", "ionice" : 4}
      { "name": "lightdm", "type": "LowLatency_RT" }
      { "name": "linphon", "type" : "LowLatency_RT", "nice" : -15, "ioclass" : "realtime" }
      { "name": "lld", "type": "compiler" }
      { "name": "lrfviewer", "type": "Doc-View" }
      { "name": "lto1-ltrans", "type": "compiler" }
      { "name": "lxdm-binary", "type": "LowLatency_RT"}
      { "name": "lxdm-session", "type": "LowLatency_RT"}
      { "name": "mailspring", "type": "Chat" }
      { "name": "mame", "type": "Game"}
      { "name": "mc", "type": "Doc-View" }
      { "name": "mednafen", "type": "Game"}
      { "name": "mednaffe", "type": "BG_CPUIO" }
      { "name": "megasync", "type": "BG_CPUIO" }
      { "name": "meld", "type": "BG_CPUIO" }
      { "name": "melt", "type": "BG_CPUIO" }
      { "name": "mesen", "type": "Game"}
      { "name": "mesen-git", "type": "Game"}
      { "name": "metro", "type": "Game"}
      { "name": "micro", "type": "Doc-View" }
      { "name": "minetest", "type": "Game" }
      { "name": "mirage", "type": "Image-View" }
      { "name": "mixxx", "type": "LowLatency_RT" }
      { "name": "mochi", "type": "Doc-View" }
      { "name": "mold", "type": "compiler" }
      { "name": "mosh", "type": "Doc-View" }
      { "name": "mpd", "type": "Player-Audio" }
      { "name": "mplayer", "type": "Player-Video" }
      { "name": "mpv", "type": "Player-Video" }
      { "name": "mullvad-daemon", "type": "IN_DIFF" }
      { "name": "mullvad-gui", "type": "IN_DIFF" }
      { "name": "nacl_helper", "type": "Doc-View" }
      { "name": "nacl_helper", "type": "Doc-View" }
      { "name": "nano", "type": "Doc-View" }
      { "name": "ncmcpp", "type": "Player-Audio" }
      { "name": "nextcloud", "type": "BG_CPUIO" }
      { "name": "nextdns", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "nix", "type": "BG_CPUIO" }
      { "name": "nix-daemon", "type": "BG_CPUIO" }
      { "name": "nix-store", "type": "BG_CPUIO" }
      { "name": "node", "type": "BG_CPUIO"}
      { "name": "ns2_linux", "type": "Game"}
      { "name": "nvdock", "type": "BG_CPUIO" }
      { "name": "nvim", "type": "Doc-View" }
      { "name": "nwmain-linux", "type": "Game"}
      { "name": "okular", "type": "Doc-View"
      { "name": "onedrive", "type": "BG_CPUIO" }
      { "name": "oneshot", "type": "Game"}
      { "name": "oosplash", "type": "Doc-View" }
      { "name": "openbox", "type": "LowLatency_RT" }
      { "name": "openrct2", "type": "Game"}
      { "name": "openvpn", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "openvpn", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "osu!", "type": "Game"}
      { "name": "owncloud", "type": "BG_CPUIO" }
      { "name": "paradiselost-bin", "type": "Game"}
      { "name": "parsecd", "type": "LowLatency_RT" }
      { "name": "payday2_release", "type": "Game"}
      { "name": "penumbra", "type": "Game"}
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "picom", "type": "LowLatency_RT" }
      { "name": "pipewire", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "plank", "type": "BG_CPUIO" }
      { "name": "plank", "type": "LowLatency_RT" }
      { "name": "plasmashell",  "nice": -1 }
      { "name": "plexmediaplayer", "type": "Player-Video" }
      { "name": "plugin_host", "type": "Doc-View" }
      { "name": "polkit-gnome-authentication-agent-1", "type": "Service"
      { "name": "polybar", "type": "LowLatency_RT" }
      { "name": "portal2_linux", "type": "Game"}
      { "name": "postal1", "type": "Game"}
      { "name": "postal2-bin", "type": "Game"}
      { "name": "psensor", "type": "BG_CPUIO" }
      { "name": "pshd", "type": "Game"}
      { "name": "pulsar, "type": "Doc-View" }
      { "name": "pulseaudio", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "qbittorrent", "type": "BG_CPUIO" }
      { "name": "qbittorrent-nox", "type": "BG_CPUIO" }
      { "name": "qemu-system-x86", "type": "VFIO" }
      { "name": "qemu-system-x86_64", "type": "VFIO" }
      { "name": "qimgv", "type": "Image-View" }
      { "name": "qmmp", "type": "Player-Audio" }
      { "name": "qtox", "type": "Chat" }
      { "name": "quake2", "type": "Game"}
      { "name": "quake3", "type": "Game"}
      { "name": "quakespasm", "type": "Game"}
      { "name": "quakespasm-svn", "type": "Game"}
      { "name": "quiterss", "type": "Doc-View" }
      { "name": "rambox", "type": "Chat" }
      { "name": "rbdoom3bfg", "type": "Game"}
      { "name": "rclone", "type": "BG_CPUIO" }
      { "name": "recollindex", "type": "BG_CPUIO" }
      { "name": "redshift", "type": "BG_CPUIO" }
      { "name": "remote-viewer", "type": "LowLatency_RT" }
      { "name": "requiem", "type": "Game"}
      { "name": "restic", "type": "BG_CPUIO"}
      { "name": "rhythmbox", "type": "Player-Audio" }
      { "name": "riot-web", "type": "LowLatency_RT" }
      { "name": "rmlint", "type": "BG_CPUIO" }
      { "name": "rott", "type": "Game"}
      { "name": "rott-registered", "type": "Game"}
      { "name": "rott-shareware", "type": "Game"}
      { "name": "rottexpr", "type": "Game"}
      { "name": "rpcs3", "type": "Game"}
      { "name": "rsession", "type": "BG_CPUIO" }
      { "name": "rstudio", "type": "LowLatency_RT" }
      { "name": "rsync", "type": "BG_CPUIO" }
      { "name": "rsync", "type": "BG_CPUIO" }
      { "name": "rtorrent", "type": "BG_CPUIO" }
      { "name": "runner", "type": "Game"}
      { "name": "rust-analyzer", "type": "compiler" }
      { "name": "rustc", "type": "compiler" }
      { "name": "sddm", "type": "LowLatency_RT"}
      { "name": "sddm-helper", "type": "LowLatency_RT"}
      { "name": "sdlmame", "type": "Game"}
      { "name": "shotwell", "type": "Image-View" }
      { "name": "shutter", "type": "Image-View" }
      { "name": "signal-desktop", "type": "Chat" }
      { "name": "signal-desktop-beta", "type": "Chat" }
      { "name": "skypeforlinux", "type": "Chat" }
      { "name": "slack", "type":"Chat" }
      { "name": "smartd", "type": "BG_CPUIO" }
      { "name": "smartgit", "type":"Doc-View" }
      { "name": "smbd", "type": "LowLatency_RT" }
      { "name": "smplayer", "type": "Player-Video" }
      { "name": "soffice.bin", "type": "Doc-View" }
      { "name": "sopcast-player", "type": "Player-Video" }
      { "name": "sopcast-player.py", "type": "Player-Video" }
      { "name": "soulseekqt", "type":"Doc-View" }
      { "name": "soundkonverter", "type": "Heavy_CPU" }
      { "name": "spectrwm", "type": "LowLatency_RT" }
      { "name": "spotify", "type": "Player-Audio" }
      { "name": "spotify", "type": "Player-Audio" }
      { "name": "ss2013.bin", "type": "Game"}
      { "name": "ssh-agent", "type": "BG_CPUIO" }
      { "name": "st", "type": "Doc-View" }
      { "name": "starbound", "type": "Game"}
      { "name": "steam", "type": "IN_DIFF" }
      { "name": "steamwebhelper", "type": "BG_CPUIO" }
      { "name": "steelstorm64", "type": "Game"}
      { "name": "stellaris", "type": "Game" }
      { "name": "stremio", "type": "Player-Video" }
      { "name": "subl3", "type": "Doc-View" }
      { "name": "sublime-text", "type": "Doc-View" }
      { "name": "sublime_merge", "type":"Doc-View" }
      { "name": "sublime_text", "type": "Doc-View" }
      { "name": "supertuxkart", "type": "Game"}
      { "name": "svencoop_linux", "type": "Game"}
      { "name": "sway", "type": "LowLatency_RT" }
      { "name": "swayidle", "type": "BG_CPUIO" }
      { "name": "syncthing", "type": "BG_CPUIO" }
      { "name": "syncthing-gtk", "type": "BG_CPUIO"
      { "name": "systemd-resolved", "type": "BG_CPUIO"
      { "name": "systemd-timesyncd", "type": "BG_CPUIO" }
      { "name": "tailscaled", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "teams", "type": "Chat" }
      { "name": "telegram", "type": "Chat" }
      { "name": "telegram-desktop", "type": "Chat" }
      { "name": "telegram-desktop.bin", "type": "Chat" }
      { "name": "thermald", "type": "BG_CPUIO" }
      { "name": "thorium", "type": "Doc-View" }
      { "name": "thorium-browser-unstable", "type": "Doc-View" }
      { "name": "thorium-shell", "type": "Doc-View" }
      { "name": "thrash-protect", "nice": -12, "ioclass": "realtime" }
      { "name": "thunderbird", "type": "Chat" }
      { "name": "tilix", "type": "Doc-View" }
      { "name": "tixati", "type": "BG_CPUIO" }
      { "name": "tmux", "type": "Doc-View" }
      { "name": "tor", "type": "Service" }
      { "name": "totem", "type": "Player-Video" }
      { "name": "transgui", "type": "BG_CPUIO" }
      { "name": "transmission-cli", "type": "BG_CPUIO" }
      { "name": "transmission-daemon", "type": "BG_CPUIO" }
      { "name": "transmission-gtk", "type": "BG_CPUIO" }
      { "name": "transmission-qt", "type": "BG_CPUIO" }
      { "name": "transmission-remote", "type": "BG_CPUIO" }
      { "name": "trine1_linux_32bit", "type": "Game"}
      { "name": "trine2_linux_32bit", "type": "Game"}
      { "name": "trine3_linux_64bit", "type": "Game"}
      { "name": "tumblerd", "type": "TODO" }
      { "name": "tyr-glquake", "type": "Game"}
      { "name": "tyr-glqwcl", "type": "Game"}
      { "name": "tyr-quake", "type": "Game"}
      { "name": "tyr-qwcl", "type": "Game"}
      { "name": "unison", "type": "BG_CPUIO"
      { "name": "uptimed", "type": "BG_CPUIO" }
      { "name": "ut-bin", "type": "Game"}
      { "name": "ut-bin-x86", "type": "Game"}
      { "name": "viber", "type":"Chat" }
      { "name": "vim", "type": "Doc-View" }
      { "name": "vivaldi-bin", "type": "Doc-View" }
      { "name": "vk", "type":"Chat" }
      { "name": "vkquake", "type": "Game"}
      { "name": "vkquake2", "type": "Game"}
      { "name": "vlc", "type": "Player-Video" }
      { "name": "vmware", "type": "Heavy_CPU" }
      { "name": "vmware-vmx", "type": "Heavy_CPU" }
      { "name": "wasteland", "type": "Game"}
      { "name": "waterfox-g", "type": "Doc-View" }
      { "name": "waybar", "type": "LowLatency_RT" }
      { "name": "wayst", "type": "Doc-View" }
      { "name": "webcord", "type": "Chat" }
      { "name": "weechat", "type": "Chat" }
      { "name": "weston", "type": "LowLatency_RT" }
      { "name": "weston", "type": "LowLatency_RT" }
      { "name": "wezterm-gui", "type": "Doc-View" }
      { "name": "wg", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "wg-quick", "type" : "LowLatency_RT", "ionice" : 1}
      { "name": "wget", "type": "BG_CPUIO" }
      { "name": "wineserver", "nice": 19, "sched": "fifo" }
      { "name": "wireplumber", "type": "LowLatency_RT", "nice": -11, "sched": "rr", "latency_nice": -11 }
      { "name": "witcher2", "type": "Game"}
      { "name": "wlsunset", "type": "BG_CPUIO" }
      { "name": "worldofwarships", "type": "Game" }
      { "name": "xarchiver", "type": "BG_CPUIO"}
      { "name": "xmobar", "type": "LowLatency_RT" }
      { "name": "xmobar", "type": "LowLatency_RT" }
      { "name": "xmonad-x86_64-linux", "type": "LowLatency_RT" }
      { "name": "xmonad-x86_64-linux", "type": "LowLatency_RT" }
      { "name": "xonotic-glx", "type": "Game"}
      { "name": "xonotic-sdl", "type": "Game"}
      { "name": "xviewer", "type": "Doc-View" }
      { "name": "yamagi-quake2", "type": "Game"}
      { "name": "yamagi-quake2-git", "type": "Game"}
      { "name": "youtube-dl", "type": "BG_CPUIO" }
      { "name": "yt-dlp", "type": "BG_CPUIO" }
      { "name": "yuzu", "type": "Game"}
      { "name": "zdoom", "type": "Game"}
      { "name": "zoom", "type": "Chat" }
      { "name":"xfce4-appfinder", "type":"LowLatency_RT"}
      { "name":"xfce4-notifyd", "type":"LowLatency_RT"}
      { "name":"xfce4-panel", "type":"LowLatency_RT"}
      { "name":"xfce4-session", "type":"LowLatency_RT"}
      { "name":"xfconfd", "type":"LowLatency_RT"}
      { "name":"xfdesktop", "type":"LowLatency_RT"}
      { "name":"xfsettingsd", "type":"LowLatency_RT"}
      { "name":"xfwm4", "type":"LowLatency_RT"}
    '';
  };
}
