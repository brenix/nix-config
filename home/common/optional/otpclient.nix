{ pkgs, ... }:
{
  home.packages = with pkgs; [
    otpclient
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/otpclient"
      ];
      files = [
        ".config/otpclient.cfg"
      ];
      allowOther = true;
    };
  };
}
