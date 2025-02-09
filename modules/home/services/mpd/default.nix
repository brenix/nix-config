{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.mpd;
in {
  options.${namespace}.services.mpd = {
    enable = mkBoolOpt false "Whether to enable mpd";
    musicDirectory = mkOpt (with types; either path str) "" "Paths containing music";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      playerctl
      mpc_cli
    ];

    services = {
      mpd = {
        enable = true;
        inherit (cfg) musicDirectory;

        network = {
          startWhenNeeded = true;
          listenAddress = "127.0.0.1";
          port = 6600;
        };

        extraConfig = ''
          auto_update           "yes"
          volume_normalization  "yes"
          restore_paused        "yes"
          filesystem_charset    "UTF-8"

          audio_output {
            type                "pipewire"
            name                "PipeWire"
          }

          audio_output {
            type                "fifo"
            name                "Visualiser"
            path                "/tmp/mpd.fifo"
            format              "44100:16:2"
          }

          audio_output {
           type		              "httpd"
           name		              "lossless"
           encoder		          "flac"
           port		              "8000"
           max_clients	        "8"
           mixer_type	          "software"
           format		            "44100:16:2"
          }

          playlist_plugin {
            name "m3u"
            enabled "true"
          }
          playlist_plugin {
            name "pls"
            enabled "true"
          }
          playlist_plugin {
            name "asx"
            enabled "false"
          }
          playlist_plugin {
            name "cue"
            enabled "false"
          }
          playlist_plugin {
            name "embcue"
            enabled "false"
          }
          playlist_plugin {
            name "xspf"
            enabled "false"
          }
        '';
      };

      mpd-mpris.enable = true;
      mpris-proxy.enable = true;

      # MPRIS 2 support to mpd
      mpdris2 = {
        enable = true;
        notifications = true;
        multimediaKeys = true;
        mpd = {
          # inherit (config.services.mpd) musicDirectory;
          musicDirectory = null;
        };
      };
    };
  };
}
