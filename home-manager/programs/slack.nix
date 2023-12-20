{ pkgs, ... }:
{
  home.packages = with pkgs; [
    slack
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Slack"
      ];
      allowOther = true;
    };
  };
}
