{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    hardware = { url = "github:nixos/nixos-hardware"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence = { url = "github:misterio77/impermanence"; }; # TODO: change to upstream after https://github.com/nix-community/impermanence/pull/99 is merged
    neovim-nightly = { url = "github:nix-community/neovim-nightly-overlay"; };
    nix-colors = { url = "github:misterio77/nix-colors"; };
    nur = { url = "github:nix-community/NUR"; };
    peerix = { url = "github:misterio77/peerix"; inputs.nixpkgs.follows = "nixpkgs"; }; # TODO change to upstream after #13 is merged
    sops-nix = { url = "github:mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs:
    let
      # Bring some functions into scope (from builtins and other flakes)
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkSystem mkHome mkDeploys importAttrset forAllSystems;
    in
    rec {
      inherit lib;

      # -- OVERLAYS
      overlays = {
        default = import ./overlay { inherit inputs; }; # Local overlay
        nur = inputs.nur.overlay;
        sops-nix = inputs.sops-nix.overlay;
        hyprland = inputs.hyprland.overlays.default;
        neovim = inputs.neovim-nightly.overlay;
        peerix = inputs.peerix.overlay;
        deploy-rs = inputs.deploy-rs.overlay;
      };

      # -- PACKAGES
      legacyPackages = forAllSystems (system:
        import inputs.nixpkgs {
          inherit system;
          overlays = builtins.attrValues overlays;
          config.allowUnfree = true;
        }
      );

      apps = forAllSystems (system: rec {
        deploy = {
          type = "app";
          program = "${legacyPackages.${system}.deploy-rs.deploy-rs}/bin/deploy";
        };
        default = deploy;
      });

      # -- DEV SHELLS (accessible via 'nix develop')
      devShells = forAllSystems (system: {
        default = legacyPackages.${system}.callPackage ./shell.nix { };
      });

      # -- MODULES
      nixosModules = importAttrset ./modules/nixos;
      homeManagerModules = importAttrset ./modules/home-manager;

      # -- SYSTEM CONFIGURATIONS (accessible via 'nixos-rebuild')
      nixosConfigurations = {
        neo = mkSystem {
          hostname = "neo";
          system = "x86_64-linux";
          persistence = true;
        };
        trinity = mkSystem {
          hostname = "trinity";
          system = "x86_64-linux";
          persistence = true;
        };
        tank = mkSystem {
          hostname = "tank";
          system = "x86_64-linux";
          persistence = true;
        };
        dozer = mkSystem {
          hostname = "dozer";
          system = "x86_64-linux";
          persistence = true;
        };
      };

      # -- HOME CONFIGURATIONS (accessible via 'home-manager')
      homeConfigurations = {
        "brenix@neo" = mkHome {
          username = "brenix";
          hostname = "neo";
          primaryDisplay = "DisplayPort-0";
          secondaryDisplay = "HDMI-A-0";
          dpi = 109;
          colorscheme = "zenbox";
          wallpaper = "island";
          persistence = true;
          features = [
            "desktop/hyprland"
          ];
        };
        "brenix@trinity" = mkHome {
          username = "brenix";
          hostname = "trinity";
          colorscheme = "zenbox";
          persistence = true;
        };
        "brenix@tank" = mkHome {
          username = "brenix";
          hostname = "tank";
          primaryDisplay = "Virtual-1";
          dpi = 220;
          colorscheme = "zenbox";
          persistence = true;
          wallpaper = "island";
          features = [
            "desktop/bspwm"
          ];
        };
        "brenix@dozer" = mkHome {
          username = "brenix";
          hostname = "dozer";
          primaryDisplay = "Virtual-1";
          colorscheme = "zenbox";
          persistence = true;
          wallpaper = "island";
          features = [
            "desktop/bspwm"
          ];
        };
      };

      deploy.nodes = mkDeploys nixosConfigurations homeConfigurations;
      deployChecks = { };

    };
}
