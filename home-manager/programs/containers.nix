{
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
    runroot = "/run/user/1000/containers/storage"
    graphroot = "/home/brenix/.containers/storage"

    [storage.options.overlay]
    mountopt = "nodev,noatime"
  '';
}
