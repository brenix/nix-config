{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wootility-lekker
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/wootility-lekker"
      ];
      allowOther = true;
    };
  };
}
