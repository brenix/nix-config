{
  xdg.configFile."containers/storage.conf".text = ''
    [storage]
    driver = "overlay"
    runroot = "/run/user/1000"
    graphroot = "/home/brenix/.containers/storage"
  '';
}
