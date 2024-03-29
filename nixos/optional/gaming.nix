{ pkgs, config, inputs, lib, ... }:
with lib; let
  cfg = config.modules.nixos.gaming;
in
{
  options.modules.nixos.gaming = {
    enable = mkEnableOption "Enable gaming features";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };

    services.ratbagd.enable = true;

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = [
          inputs.nix-gaming.packages.${pkgs.system}.proton-ge
        ];
      };
    };

    environment.systemPackages = with pkgs; [
      winetricks
      wineWowPackages.waylandFull
    ];
  };
}
