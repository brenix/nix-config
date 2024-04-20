{ config
, lib
, pkgs
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.services.ananicy;
in
{
  options.services.ananicy = with types; {
    enable = mkBoolOpt false "Enable ananicy";
  };

  config = mkIf cfg.enable {
    services.ananicy = {
      enable = true;
      package = pkgs.ananicy-cpp;
      rulesProvider = pkgs.ananicy-cpp-rules; # chaotic-nyx
      settings = {
        check_freq = 15;
        cgroup_load = true;
        type_load = true;
        rule_load = true;
        apply_nice = true;
        apply_latnice = true;
        apply_ioclass = true;
        apply_ionice = true;
        apply_sched = true;
        apply_oom_score_adj = true;
        apply_cgroup = true;
        check_disks_schedulers = true;
      };
    };
  };
}
