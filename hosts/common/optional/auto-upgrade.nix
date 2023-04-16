{
  system.autoUpgrade = {
    enable = true;
    allowReboot = true;
    randomizedDelaySec = "120";
    rebootWindow = {
      lower = "03:00";
      upper = "06:00";
    };
    flake = "github:brenix/nix-config";
    flags = [
      # NOTE(brenix): disabled so that it tracks the flake lock instead
      #"--recreate-lock-file"
      #"--no-write-lock-file"
      "--impure"
    ];
  };
}
