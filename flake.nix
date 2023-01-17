{
  description = "My NixOS configuration";

  inputs = {
    firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/hyprland/v0.15.3beta"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprwm-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836"; # Temporary fix - Remove once fixed upstream (https://github.com/nix-community/neovim-nightly-overlay/issues/164)
    nix-colors.url = "github:misterio77/nix-colors";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    sops-nix = { url = "github:mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (nixpkgs.lib) filterAttrs traceVal;
      inherit (builtins) mapAttrs elem;
      inherit (self) outputs;
      notBroken = x: !(x.meta.broken or false);
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    rec {
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      overlays = import ./overlays;

      legacyPackages = forAllSystems (system:
        import nixpkgs {
          inherit system;
          overlays = with overlays; [ additions wallpapers modifications ];
          config.allowUnfree = true;
        }
      );

      packages = forAllSystems (system:
        import ./pkgs { pkgs = legacyPackages.${system}; }
      );

      devShells = forAllSystems (system: {
        default = import ./shell.nix { pkgs = legacyPackages.${system}; };
      });

      nixosConfigurations = rec {
        # Desktop
        neo = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/neo ];
        };
        # Laptop
        tank = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/tank ];
        };
        # Server
        trinity = nixpkgs.lib.nixosSystem {
          pkgs = legacyPackages."x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/trinity ];
        };
      };

      homeConfigurations = {
        # Desktop
        "brenix@neo" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/brenix/neo.nix ];
        };
        # Laptop
        "brenix@tank" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/brenix/tank.nix ];
        };
        # Server
        "brenix@trinity" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/brenix/trinity.nix ];
        };
        # For easy bootstrapping from a nixos live usb
        "nixos@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = legacyPackages."x86_64-linux";
          extraSpecialArgs = { inherit inputs outputs; };
          modules = [ ./home/brenix/generic.nix ];
        };
      };
    };
}
