{ pkgs, ... }:
{
  home.packages = with pkgs; [
    todoist
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [ ".config/todoist" ];
      allowOther = true;
    };
  };
}
