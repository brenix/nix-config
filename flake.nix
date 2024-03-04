{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    disko.url = "github:nix-community/disko";
    firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprwm-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-colors.url = "github:misterio77/nix-colors";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nur.url = "github:nix-community/NUR";
    sops-nix = { url = "github:mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };

    # nixvim.url = "github:nix-community/nixvim";
    # helix-master.url = "github:helix-editor/helix";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , chaotic
    , ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (sys: f pkgsFor.${sys});
      pkgsFor = lib.genAttrs systems (system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in
    {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays { inherit inputs outputs; };
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });

      nixosConfigurations = {
        # ISO
        iso = lib.nixosSystem {
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
            ./hosts/iso/configuration.nix
          ];
          specialArgs = { inherit inputs outputs; };
        };

        # Desktops
        neo = lib.nixosSystem {
          modules = [ ./hosts/neo/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };

        trinity = lib.nixosSystem {
          modules = [ ./hosts/trinity/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };

        # Laptops
        morpheus = lib.nixosSystem {
          modules = [ ./hosts/morpheus/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };

        # VMs
        tank = lib.nixosSystem {
          modules = [ ./hosts/tank/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        # Desktops
        "brenix@neo" = lib.homeManagerConfiguration {
          modules = [ ./hosts/neo/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        "brenix@trinity" = lib.homeManagerConfiguration {
          modules = [ ./hosts/trinity/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # Laptops
        "brenix@morpheus" = lib.homeManagerConfiguration {
          modules = [ ./hosts/morpheus/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # VMs
        "brenix@tank" = lib.homeManagerConfiguration {
          modules = [ ./hosts/tank/home.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
