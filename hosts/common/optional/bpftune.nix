{ pkgs, ... }:
# TODO: Remove once merged upstream
{
  systemd.packages = [ pkgs.bpftune ];
  systemd.services.bpftune.wantedBy = [ "multi-user.target" ];
}