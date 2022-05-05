_: {

  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "cake";
        "net.core.netdev_max_backlog" = 16384;
        "net.core.optmem_max" = 65536;
        "net.core.rmem_default" = 1048576;
        "net.core.rmem_max" = 16777216;
        "net.core.somaxconn" = 8192;
        "net.core.wmem_default" = 1048576;
        "net.core.wmem_max" = 16777216;
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.tcp_fastopen" = 3;
        "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        "net.ipv4.tcp_timestamps" = 0;
        "net.ipv4.tcp_wmem" = "4096 65536 16777216";
        "net.ipv4.udp_rmem_min" = 8192;
        "net.ipv4.udp_wmem_min" = 8192;
        "vm.dirty_background_ratio" = 20;
        "vm.dirty_ratio" = 50;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 10;
      };
    };
  };

}
