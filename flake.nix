{
  description = "NixOS configuration";

  inputs = {
    # Nix pkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim nightly
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nur, nix-colors, neovim-nightly-overlay, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
    in
    {
    nixosConfigurations = {
      neo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/neo.nix
          ./users/brenix/packages.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.brenix = import ./users/brenix/home.nix;
            nixpkgs.overlays = [
              nur.overlay
              neovim-nightly-overlay.overlay
            ];
          }
        ];
      };

      dozer = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/dozer.nix
          ./users/brenix/packages.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.brenix = import ./users/brenix/home.nix;
            nixpkgs.overlays = [
              nur.overlay
              neovim-nightly-overlay.overlay
            ];
          }
        ];
      };

      tank = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./hosts/tank.nix
          ./users/brenix/packages.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.brenix = import ./users/brenix/home.nix;
            nixpkgs.overlays = [
              nur.overlay
              neovim-nightly-overlay.overlay
            ];
          }
        ];
      };
    };
  };
}
