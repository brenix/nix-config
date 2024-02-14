{ config, ... }: {
  programs.atuin = {
    enable = true;
    flags = [
      "--disable-up-arrow"
    ];
    settings = {
      sync_frequency = "15m";
      enter_accept = false;
      key_path = config.sops.secrets.atuin_key.path;
    };
  };

  sops.secrets.atuin_key = {
    sopsFile = ../secrets.yaml;
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".local/share/atuin"
      ];
      allowOther = true;
    };
  };
}
