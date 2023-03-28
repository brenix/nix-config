{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--wm-window-animations-disabled"
    ];
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [ ".config/chromium" ];
      allowOther = true;
    };
  };
}
