{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/discord"
      ];
      allowOther = true;
    };
  };
}
