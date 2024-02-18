{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.node-exporter;
in
{
  options.modules.nixos.node-exporter = {
    enable = mkEnableOption "Enable node-exporter service";
  };

  config = mkIf cfg.enable {
    services.prometheus.exporters.node.enable = true;
  };
}
