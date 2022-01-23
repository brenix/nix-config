_: {

  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.tcp_fastopen" = 3;
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        "vm.dirty_background_ratio" = 20;
        "vm.dirty_ratio" = 50;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 50;
      };
    };
  };

}
