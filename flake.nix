{
  description = "brenix's Nix/NixOS Config";

  inputs = {
    # Base packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Lix
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hardware support
    hardware.url = "github:nixos/nixos-hardware";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix user repository
    nur.url = "github:nix-community/NUR";

    # Snowfall lib
    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    # MacOS support
    darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # SOPS (secrets)
    sops-nix.url = "github:mic92/sops-nix";

    # Bleeding edge packages (linux-cachyos)
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # textfox
    textfox.url = "github:adriankarlen/textfox";

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # OpenGL wrapper for nix
    # nixgl.url = "github:nix-community/nixGL";

    # Colorscheme management
    # TODO: re-enable upstream once hyprland stuff is fixed
    # stylix.url = "github:danth/stylix";
    stylix.url = "github:brenix/stylix/hyprland-removals";

    # Catppuccin colorscheme
    catppuccin.url = "github:catppuccin/nix";

    # Nix index database
    nix-index-database.url = "github:nix-community/nix-index-database";

    # Declarative disk management
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    # Remote installation support
    nixos-anywhere.url = "github:numtide/nixos-anywhere";
    nixos-anywhere.inputs.nixpkgs.follows = "nixpkgs";
    nixos-anywhere.inputs.disko.follows = "disko";

    # Hyprland - Cursor
    hyprcursor.url = "github:hyprwm/Hyprcursor";
    hyprcursor.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland - Idle
    # hypridle.url = "github:hyprwm/Hypridle";
    # hypridle.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland - Scratchpad and Extras
    # pyprland.url = "github:hyprland-community/pyprland";
    # pyprland.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland - Main
    hyprland-git.url = "github:hyprwm/hyprland";
    hyprland-xdph-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprland-protocols-git.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprland-nix.url = "github:spikespaz/hyprland-nix";
    hyprland-nix.inputs.hyprland.follows = "hyprland-git";
    hyprland-nix.inputs.hyprland-xdph.follows = "hyprland-xdph-git";
    hyprland-nix.inputs.hyprland-protocols.follows = "hyprland-protocols-git";

    # Labwc configuration
    labwc-manager.url = "github:JaydenPahukula/labwc-manager";

    # Talhelper
    talhelper.url = "github:budimanjojo/talhelper";

    # Ghostty
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
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
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        sops-nix.nixosModules.sops
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

      homes.modules = with inputs; [
        catppuccin.homeModules.catppuccin
        stylix.homeManagerModules.stylix
        labwc-manager.homeManagerModule
        textfox.homeManagerModules.default
      ];

      overlays = with inputs; [
        # nixgl.overlay
        lix.overlays.default
        chaotic.overlays.default
        nur.overlays.default
        talhelper.overlays.default
      ];

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };
    };
}
