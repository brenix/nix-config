{ pkgs, ... }:
{
  home.packages = with pkgs; [
    epr
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/epr"
      ];
      allowOther = true;
    };
  };
}
