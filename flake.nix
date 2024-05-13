{
  description = "brenix's Nix/NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # FIXME: Remove after snowfall lib is updated
    snowfall-lib.inputs.flake-utils-plus.url = "github:fl42v/flake-utils-plus";

    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:mic92/sops-nix";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    impermanence.url = "github:nix-community/impermanence";

    nixgl.url = "github:nix-community/nixGL";

    nix-colors.url = "github:misterio77/nix-colors";

    catppuccin.url = "github:catppuccin/nix";

    nix-ld.url = "github:Mic92/nix-ld";

    nix-index-database.url = "github:nix-community/nix-index-database";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    nixos-anywhere.url = "github:numtide/nixos-anywhere";
    nixos-anywhere.inputs.nixpkgs.follows = "nixpkgs";
    nixos-anywhere.inputs.disko.follows = "disko";

    nixos-generators.url = "github:nix-community/nixos-generators";
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";

    comma.url = "github:nix-community/comma";
    comma.inputs.nixpkgs.follows = "nixpkgs";

    hypr-contrib.url = "github:hyprwm/Hyprcursor";
    hypr-contrib.inputs.nixpkgs.follows = "nixpkgs";

    hyprcursor.url = "github:hyprwm/Hyprcursor";
    hyprcursor.inputs.nixpkgs.follows = "nixpkgs";

    hypridle.url = "github:hyprwm/Hypridle";
    hypridle.inputs.nixpkgs.follows = "nixpkgs";

    pyprland.url = "github:hyprland-community/pyprland";
    pyprland.inputs.nixpkgs.follows = "nixpkgs";

    hyprland-git.url = "github:hyprwm/hyprland";
    hyprland-xdph-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprland-protocols-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprland-nix.url = "github:spikespaz/hyprland-nix";
    hyprland-nix.inputs.hyprland.follows = "hyprland-git";
    hyprland-nix.inputs.hyprland-xdph.follows = "hyprland-xdph-git";
    hyprland-nix.inputs.hyprland-protocols.follows = "hyprland-protocols-git";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      snowfall = {
        metadata = "matrix";
        namespace = "matrix";
        meta = {
          name = "matrix";
          title = "brenix's Nix Flake";
        };
      };

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
        nix-ld.nixosModules.nix-ld
        catppuccin.nixosModules.catppuccin
        chaotic.nixosModules.default
        {
          # manually import overlay
          chaotic.nyx.overlay.enable = false;
        }
      ];

      systems.modules.darwin = with inputs; [
        home-manager.darwinModules.home-manager
      ];

      systems.hosts.neo.modules = with inputs; [
        hardware.nixosModules.common-cpu-amd
        hardware.nixosModules.common-gpu-amd
        hardware.nixosModules.common-pc-ssd
      ];

      systems.hosts.morpheus.modules = with inputs; [
        hardware.nixosModules.framework-13-7040-amd
      ];

      systems.hosts.trinity.modules = with inputs; [
        hardware.nixosModules.common-cpu-intel
        hardware.nixosModules.common-pc-ssd
      ];

      # homes.modules = with inputs; [
      #   impermanence.nixosModules.home-manager.impermanence
      # ];

      overlays = with inputs; [
        nixgl.overlay
        chaotic.overlays.default
        nur.overlay
      ];
    };
}
