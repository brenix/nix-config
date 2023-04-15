{
  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/Authy Desktop"
        ".config/Slack"
        ".config/Unknown Organization" # Zoom
        ".config/discord"
        ".config/obsidian"
        ".config/spotify"
        ".config/wootility-lekker"
        ".zoom"
      ];
      files = [
        ".config/zoomus.conf"
        ".config/zoom.conf"
      ];
      allowOther = true;
    };
  };
}
