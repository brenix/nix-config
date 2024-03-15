{ pkgs, config, inputs, lib, ... }:
with lib; let
  cfg = config.modules.nixos.gaming;
in
{
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  options.modules.nixos.gaming = {
    enable = mkEnableOption "Enable gaming features";
  };

  config = mkIf cfg.enable {
    nix.settings = {
      substituters = [ "https://nix-gaming.cachix.org" ];
      trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];
    };

    # services.ratbagd.enable = true;

    programs = {
      gamemode.enable = true;
      gamescope.enable = true;
      steam = {
        enable = true;
        gamescopeSession.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-custom # chaotic-nyx
        ];
      };
    };

    chaotic.steam.extraCompatPackages = with pkgs; [
      proton-ge-custom # chaotic-nyx
    ];

    services.pipewire = {
      lowLatency = {
        enable = true;
      };
    };
    security.rtkit.enable = true;


    environment.systemPackages = with pkgs; [
      winetricks
      wineWowPackages.waylandFull
    ];
  };
}
