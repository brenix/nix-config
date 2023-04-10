{
  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr2";
        "net.ipv4.tcp_fastopen" = 3;
        "net.ipv4.tcp_slow_start_after_idle" = 0;
        "vm.dirty_background_ratio" = 5;
        "vm.dirty_ratio" = 10;
        "vm.min_free_kbytes" = 524288;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 10;

        # https://blog.cloudflare.com/optimizing-tcp-for-high-throughput-and-low-latency/
        "net.ipv4.tcp_rmem" = "8192 262144 536870912";
        "net.ipv4.tcp_wmem" = "4096 16384 536870912";
        "net.ipv4.tcp_adv_win_scale" = -2;
        "net.ipv4.tcp_collapse_max_bytes" = 6291456;
        "net.ipv4.tcp_notsent_lowat" = 131072;
      };
    };
  };
}
