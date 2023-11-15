{
  services.syncthing = {
    enable = true;
    user = "brenix";
    overrideDevices = true;
    overrideFolders = true;
    openDefaultPorts = true;
    dataDir = "/home/brenix/syncthing";
  };

  environment.persistence = {
    "/persist".directories = [
      "/home/brenix/syncthing"
    ];
  };
}
