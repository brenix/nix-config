{
  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".local/share/zoxide"
      ];
      allowOther = true;
    };
  };
}
