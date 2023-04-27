{ pkgs, ... }:
{
  home.packages = with pkgs; [
    playerctl
    (spotify.override {
      callPackage = p: attrs: pkgs.callPackage p (attrs // { nss = nss_latest; });
    })
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
