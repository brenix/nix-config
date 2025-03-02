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
      kernel = {
        sysctl = {
          # "fs.file-max" = 5242880;
          "fs.inotify.max_user_instances" = 8192;
          "fs.inotify.max_user_watches" = 1048576;
          "fs.xfs.xfssyncd_centisecs" = 10000;
          "kernel.nmi_watchdog" = 0;
          "kernel.printk" = "3 3 3 3";
          "kernel.split_lock_mitigate" = 0;
          "kernel.unprivileged_userns_clone" = 1;
          "net.core.default_qdisc" = "fq";
          "net.core.netdev_max_backlog" = 16384;
          "net.core.optmem_max" = 67108864;
          "net.core.rmem_max" = 67108864;
          "net.core.somaxconn" = 8192;
          "net.core.wmem_max" = 67108864;
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
          "net.ipv4.tcp_rmem" = "4096 87380 33554432";
          "net.ipv4.tcp_sack" = 1;
          "net.ipv4.tcp_shrink_window" = 1;
          "net.ipv4.tcp_slow_start_after_idle" = 0;
          "net.ipv4.tcp_syn_linear_timeouts" = 2;
          "net.ipv4.tcp_syn_retries" = 3;
          "net.ipv4.tcp_syncookies" = 1;
          "net.ipv4.tcp_timestamps" = 1;
          "net.ipv4.tcp_tw_reuse" = 0;
          "net.ipv4.tcp_wmem" = "4096 65536 33554432";
          "net.ipv4.udp_rmem_min" = 8192;
          "net.ipv4.udp_wmem_min" = 8192;
          "vm.dirty_background_bytes" = 67108864;
          "vm.dirty_bytes" = 268435456;
          "vm.dirty_writeback_centisecs" = 1500;
          "vm.max_map_count" = 1048576;
          "vm.min_free_kbytes" = 524288;
          "vm.page-cluster" = 0;
          "vm.swappiness" = 100;
          "vm.vfs_cache_pressure" = 50;
        };
      };
    };

    systemd.tmpfiles.rules = [
      # Clear all coredumps that were created more than 3 days ago
      "d /var/lib/systemd/coredump 0755 root root 3d"

      # Disable zswap
      "w! /sys/module/zswap/parameters/enabled - - - - N"

      # Increase the highest requested RTC interrupt frequency
      "w! /sys/class/rtc/rtc0/max_user_freq - - - - 3072"
      "w! /proc/sys/dev/hpet/max-user-freq  - - - - 3072"

      # THP Shrinker has been added in the 6.12 Kernel
      # Default Value is 511
      # THP=always policy vastly overprovisions THPs in sparsely accessed memory areas, resulting in excessive memory pressure and premature OOM killing
      # 409 means that any THP that has more than 409 out of 512 (80%) zero filled filled pages will be split.
      # This reduces the memory usage, when THP=always used and the memory usage goes down to around the same usage as when madvise is used, while still providing an equal performance improvement
      "w! /sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none - - - - 409"

      # Improve performance for applications that use tcmalloc
      # https://github.com/google/tcmalloc/blob/master/docs/tuning.md#system-level-optimizations
      "w! /sys/kernel/mm/transparent_hugepage/defrag - - - - defer+madvise"
    ];
  };
}
