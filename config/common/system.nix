_: {

  system = {
    stateVersion = "21.05";
  };

  # Create symlink for bash for compatibility reasons
  systemd.tmpfiles.rules =
    [ "L /bin/bash - - - - /run/current-system/sw/bin/bash" ];
}
