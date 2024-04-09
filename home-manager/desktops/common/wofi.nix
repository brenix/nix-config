{ config, pkgs, lib, ... }:
with lib;
let
  cfg = config.modules.wms.launchers.wofi;
in
{
  options.modules.wms.launchers.wofi = {
    enable = mkEnableOption "enable wofi launcher";
  };

  config = mkIf cfg.enable {
    programs.wofi = {
      enable = true;
    };
  };
}
