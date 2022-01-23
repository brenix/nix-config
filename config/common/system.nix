{ ... }: {

  system = {
    stateVersion = "21.05";
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      randomizedDelaySec = "120";
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
