{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
    spotify
  ];

  services.playerctld = {
    enable = true;
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/spotify"
      ];
      allowOther = true;
    };
  };
}
