{ pkgs, config, ... }: {

  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    android-tools
  ];

  services.udev.packages = [
    pkgs.android-udev-rules
  ];
}
