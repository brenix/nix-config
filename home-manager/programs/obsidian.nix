{ pkgs, ... }:
{
  home.packages = with pkgs; [
    obsidian
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/obsidian"
      ];
      allowOther = true;
    };
  };
}
