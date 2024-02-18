{ config, lib, pkgs, ... }:
with lib; let
  cfg = config.modules.nixos.opengl;
in
{
  options.modules.nixos.opengl = {
    enable = mkEnableOption "Enable OpenGL";
  };

  config = mkIf cfg.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
          mesa
        ];
      };
    };
  };
}
