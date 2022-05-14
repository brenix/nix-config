_: {

  system = {
    stateVersion = "21.05";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      randomizedDelaySec = "120";
      rebootWindow = {
        lower = "03:00";
        upper = "06:00";
      };
      flake = "github:brenix/nixos-config";
      flags = [
        "--recreate-lock-file"
        "--no-write-lock-file"
        "-L" # print build logs
        # "--impure"
      ];
    };
  };

  # Create symlink for bash for compatibility reasons
  systemd.tmpfiles.rules =
    [ "L /bin/bash - - - - /run/current-system/sw/bin/bash" ];
}
