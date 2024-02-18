{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.pipewire;
in
{
  options.modules.nixos.pipewire = {
    enable = mkEnableOption "Enable pipewire";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
      socketActivation = true;
    };
  };
}
