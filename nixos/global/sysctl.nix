{
  boot = {
    kernelModules = [ "tcp_bbr" ];
    kernel = {
      sysctl = {
        # The BBR congestion control algorithm can help achieve higher bandwidths and lower latencies for internet traffic
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";

        # TCP Fast Open is an extension to the transmission control protocol (TCP) that helps reduce network latency
        # by enabling data to be exchanged during the sender’s initial TCP SYN [3].
        # Using the value 3 instead of the default 1 allows TCP Fast Open for both incoming and outgoing connections
        "net.ipv4.tcp_fastopen" = 3;

        # Disable TCP slow start on idle connections
        "net.ipv4.tcp_slow_start_after_idle" = 0;

        # page-cluster controls the number of pages up to which consecutive pages are read in from swap in a single attempt.
        # This is the swap counterpart to page cache readahead. The mentioned consecutivity is not in terms of virtual/physical addresses,
        # but consecutive on swap space - that means they were swapped out together. (Default is 3)
        # increase this value to 1 or 2 if you are using physical swap (1 if ssd, 2 if hdd)
        "vm.page-cluster" = 0;

        # This tunable is used to define when dirty data is old enough to be eligible for writeout by the
        # kernel flusher threads.  It is expressed in 100'ths of a second.  Data which has been dirty
        # in-memory for longer than this interval will be written out next time a flusher thread wakes up
        # (Default is 3000).
        #"vm.dirty_expire_centisecs" = 3000;

        # The kernel flusher threads will periodically wake up and write old data out to disk.  This
        # tunable expresses the interval between those wakeups, in 100'ths of a second (Default is 500).
        "vm.dirty_writeback_centisecs" = 1500;

        # This file contains the maximum number of memory map areas a process may have. Memory map areas are used as a side-effect of calling malloc, directly by mmap, mprotect, and madvise, and also when loading shared libraries.
        # While most applications need less than a thousand maps, certain programs, particularly malloc debuggers, may consume lots of them, e.g., up to one or two maps per allocation.
        # The default value is 65536
        # Value is higher set to fix games like DayZ, Hogwarts Legacy, Counter Strike 2
        "vm.max_map_count" = 2147483642;

        # Enable the sysctl setting kernel.unprivileged_userns_clone to allow normal users to run unprivileged containers.
        "kernel.unprivileged_userns_clone" = 1;

        # To hide any kernel messages from the console
        "kernel.printk" = "3 3 3 3";

        # Increasing the size of the receive queue.
        # The received frames will be stored in this queue after taking them from the ring buffer on the network card.
        # Increasing this value for high speed cards may help prevent losing packets:
        "net.core.netdev_max_backlog" = 16384;

        # Increase the maximum connections
        # The upper limit on how many connections the kernel will accept (default 128):
        "net.core.somaxconn" = 8192;

        # Increase min_free_kbytes to avoid lag spikes due to low memory situations
        "vm.min_free_kbytes" = 524288;

        # Contains, as a bytes of total available memory that contains free pages and reclaimable
        # pages, the number of pages at which a process which is generating disk writes will itself start
        # writing out dirty data
        "vm.dirty_bytes" = 268435456;
        "vm.dirty_background_bytes" = 134217728;

        # Disable swappiness
        # The sysctl swappiness parameter determines the kernel's preference for pushing anonymous pages or page cache to disk in memory-starved situations.
        # A low value causes the kernel to prefer freeing up open files (page cache), a high value causes the kernel to try to use swap space,
        # and a value of 100 means IO cost is assumed to be equal.
        "vm.swappiness" = 100;

        # The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache).
        # Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
        "vm.vfs_cache_pressure" = 10;

        # TCP SYN cookie protection
        # Helps protect against SYN flood attacks. Only kicks in when net.ipv4.tcp_max_syn_backlog is reached:
        "net.ipv4.tcp_syncookies" = 1;

        # TCP Enable ECN Negotiation by default
        "net.ipv4.tcp_ecn" = 1;

        # TCP reduce performance spikes
        "net.ipv4.tcp_timestamps" = 0;

        # Increase the memory dedicated to the network interfaces
        # https://blog.cloudflare.com/optimizing-tcp-for-high-throughput-and-low-latency/
        "net.core.rmem_default" = 1048576;
        "net.core.rmem_max" = 16777216;
        "net.core.wmem_default" = 1048576;
        "net.core.wmem_max" = 16777216;
        "net.core.optmem_max" = 65536;
        "net.ipv4.tcp_rmem" = "8192 262144 536870912";
        "net.ipv4.tcp_wmem" = "4096 16384 536870912";
        "net.ipv4.tcp_adv_win_scale" = -2;
        "net.ipv4.tcp_collapse_max_bytes" = 6291456;
        "net.ipv4.tcp_notsent_lowat" = 131072;
        "net.ipv4.udp_rmem_min" = 8192;
        "net.ipv4.udp_wmem_min" = 8192;

        # Increase writeback interval for xfs
        "fs.xfs.xfssyncd_centisecs" = 10000;

        # Disable split lock mitigate - known to cause performance issues in applications and games
        "kernel.split_lock_mitigate" = 0;

        # Disable the NMI watchdog
        "kernel.nmi_watchdog" = 0;

        # Set the maximum watches on files
        "fs.inotify.max_user_watches" = 524288;

        # Set size of file handles and inode cache
        "fs.file-max" = 2097152;
      };
    };
  };
}
