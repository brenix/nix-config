{ config, lib, ... }:
with lib; let
  cfg = config.modules.nixos.auto-login;
in
{
  options.modules.nixos.auto-login = {
    enable = mkEnableOption "Enable automatic login";
  };

  config = mkIf cfg.enable {
    services.getty.autologinUser = "brenix";
  };
}
