{ lib, config, ... }:
with lib; let
  cfg = config.modules.nixos.clipcat;
in
{
  options.modules.nixos.clipcat = {
    enable = mkEnableOption "Enable the clipcat clipboard manager";
  };
  config = mkIf cfg.enable {
    services.clipcat.enable = true;
  };
}
