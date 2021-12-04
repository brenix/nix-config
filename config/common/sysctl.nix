{ config, lib, ... }: {

  boot = {
    kernel = {
      sysctl = {
        "vm.dirty_background_ratio" = 20;
        "vm.dirty_ratio" = 50;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 50;
      };
    };
  };

}
