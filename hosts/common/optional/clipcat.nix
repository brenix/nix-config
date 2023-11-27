{
  services.clipcat.enable = true;

  environment.persistence = {
    "/persist".directories = [
      "/home/brenix/.config/clipcat"
    ];
  };
}
