{
  description = "My NixOS configuration";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    firefox-addons = { url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons"; inputs.nixpkgs.follows = "nixpkgs"; };
    hardware.url = "github:nixos/nixos-hardware";
    # helix-master.url = "github:helix-editor/helix";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprwm-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence.url = "github:nix-community/impermanence";
    # neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixvim.url = "github:nix-community/nixvim";
    nur.url = "github:nix-community/NUR";
    sops-nix = { url = "github:mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, home-manager, chaotic, nixvim, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      systems = [ "x86_64-linux" ];
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
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
        neo = lib.nixosSystem {
          modules = [ ./hosts/neo chaotic.nixosModules.default ];
          specialArgs = { inherit inputs outputs; };
        };
        trinity = lib.nixosSystem {
          modules = [ ./hosts/trinity chaotic.nixosModules.default ];
          specialArgs = { inherit inputs outputs; };
        };
        tank = lib.nixosSystem {
          modules = [ ./hosts/tank chaotic.nixosModules.default ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      homeConfigurations = {
        "brenix@neo" = lib.homeManagerConfiguration {
          modules = [ ./home/brenix/neo.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "brenix@trinity" = lib.homeManagerConfiguration {
          modules = [ ./home/brenix/trinity.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "brenix@tank" = lib.homeManagerConfiguration {
          modules = [ ./home/brenix/tank.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
