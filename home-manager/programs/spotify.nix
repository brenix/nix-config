{ pkgs, ... }:
{
  home.packages = with pkgs; [
    spotify
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/spotify"
      ];
      allowOther = true;
    };
  };
}
