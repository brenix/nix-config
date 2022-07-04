_: {

  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_adv_win_scale" = -2;
        "net.ipv4.tcp_congestion_control" = "bbr";
        "net.ipv4.tcp_fastopen" = 3;
        "net.ipv4.tcp_low_latency" = 1;
        "net.ipv4.tcp_sack" = 0;
        "net.ipv4.tcp_timestamps" = 0;
        "net.ipv4.tcp_notsent_lowat" = 131072;
        "net.ipv4.tcp_rmem" = "8192 262144 536870912";
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        "net.ipv4.tcp_wmem" = "4096 16384 536870912";
        "vm.dirty_background_ratio" = 20;
        "vm.dirty_ratio" = 50;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 10;
      };
    };
  };

}
