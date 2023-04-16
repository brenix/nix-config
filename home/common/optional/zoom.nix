{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zoom-us
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Unknown Organization" # Zoom
        ".zoom"
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
      ];
      allowOther = true;
    };
  };
}
