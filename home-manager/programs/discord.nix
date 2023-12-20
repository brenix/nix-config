{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord-krisp # chaotic-nyx
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
