{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.sysctl;
in {
  options.${namespace}.system.sysctl = {
    enable = mkBoolOpt false "Whether or not to enable sysctl tunings.";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = ["tcp_bbr"];
      kernel = {
        sysctl = {
          "fs.file-max" = 2097152;
          "fs.inotify.max_user_instances" = 1024;
          "fs.inotify.max_user_watches" = 524288;
          "fs.xfs.xfssyncd_centisecs" = 10000;
          "kernel.nmi_watchdog" = 0;
          "kernel.printk" = "3 3 3 3";
          "kernel.split_lock_mitigate" = 0;
          "kernel.unprivileged_userns_clone" = 1;
          "net.core.default_qdisc" = "fq";
          "net.core.netdev_max_backlog" = 16384;
          "net.core.optmem_max" = 16777216;
          "net.core.rmem_max" = 16777216;
          "net.core.somaxconn" = 8192;
          "net.core.wmem_max" = 16777216;
          "net.ipv4.tcp_adv_win_scale" = -2;
          "net.ipv4.tcp_collapse_max_bytes" = 6291456;
          "net.ipv4.tcp_congestion_control" = "bbr";
          "net.ipv4.tcp_dsack" = 1;
          "net.ipv4.tcp_ecn" = 0;
          "net.ipv4.tcp_fastopen" = 3;
          "net.ipv4.tcp_keepalive_intvl" = 60;
          "net.ipv4.tcp_keepalive_probes" = 3;
          "net.ipv4.tcp_keepalive_time" = 1800;
          "net.ipv4.tcp_mtu_probing" = 1;
          "net.ipv4.tcp_notsent_lowat" = 131072;
          "net.ipv4.tcp_retries1" = 2;
          "net.ipv4.tcp_rmem" = "4096 32768 33554432";
          "net.ipv4.tcp_sack" = 1;
          "net.ipv4.tcp_shrink_window" = 1;
          "net.ipv4.tcp_slow_start_after_idle" = 0;
          "net.ipv4.tcp_syn_linear_timeouts" = 2;
          "net.ipv4.tcp_syn_retries" = 3;
          "net.ipv4.tcp_syncookies" = 1;
          "net.ipv4.tcp_timestamps" = 1;
          "net.ipv4.tcp_tw_reuse" = 0;
          "net.ipv4.tcp_wmem" = "4096 16384 33554432";
          "net.ipv4.udp_rmem_min" = 8192;
          "net.ipv4.udp_wmem_min" = 8192;
          "vm.dirty_background_bytes" = 134217728;
          "vm.dirty_bytes" = 268435456;
          "vm.dirty_writeback_centisecs" = 1500;
          "vm.max_map_count" = 1048576;
          "vm.min_free_kbytes" = 524288;
          "vm.page-cluster" = 0;
          "vm.swappiness" = 100;
          "vm.vfs_cache_pressure" = 10;
        };
      };
    };
  };
}
