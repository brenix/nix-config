{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    hardware = { url = "github:nixos/nixos-hardware"; };
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };

    deploy-rs = { url = "github:serokell/deploy-rs"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprland = { url = "github:hyprwm/hyprland"; inputs.nixpkgs.follows = "nixpkgs"; };
    hyprwm-contrib = { url = "github:hyprwm/contrib"; inputs.nixpkgs.follows = "nixpkgs"; };
    impermanence = { url = "github:nix-community/impermanence"; };
    neovim-nightly = { url = "github:nix-community/neovim-nightly-overlay"; };
    nix-colors = { url = "github:misterio77/nix-colors"; };
    nur = { url = "github:nix-community/NUR"; };
    peerix = { url = "github:cid-chan/peerix"; inputs.nixpkgs.follows = "nixpkgs"; };
    sops-nix = { url = "github:mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = inputs:
    let
      # Bring some functions into scope (from builtins and other flakes)
      lib = import ./lib { inherit inputs; };
      inherit (lib) mkSystem mkHome mkDeploys forAllSystems;
    in
    rec {
      inherit lib;

      # -- OVERLAYS
      overlays = {
        default = import ./overlay { inherit inputs; }; # Local overlay
        nur = inputs.nur.overlay;
        sops-nix = inputs.sops-nix.overlay;
        hyprland = inputs.hyprland.overlays.default;
        hyprwm-contrib = inputs.hyprwm-contrib.overlays.default;
        /* neovim = inputs.neovim-nightly.overlay; */
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
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;

      # -- SYSTEM CONFIGURATIONS (accessible via 'nixos-rebuild')
      nixosConfigurations = {
        neo = mkSystem {
          hostname = "neo";
          pkgs = legacyPackages."x86_64-linux";
          persistence = true;
        };
        trinity = mkSystem {
          hostname = "trinity";
          pkgs = legacyPackages."x86_64-linux";
          persistence = true;
        };
        tank = mkSystem {
          hostname = "tank";
          pkgs = legacyPackages."x86_64-linux";
          persistence = true;
        };
        dozer = mkSystem {
          hostname = "dozer";
          pkgs = legacyPackages."x86_64-linux";
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
          dpi = 108;
          colorscheme = "catppuccin-mocha";
          wallpaper = "evening-sky";
          persistence = true;
          features = [
            "desktop/bspwm"
          ];
        };
        "brenix@trinity" = mkHome {
          username = "brenix";
          hostname = "trinity";
          colorscheme = "nord";
          persistence = true;
        };
        "brenix@tank" = mkHome {
          username = "brenix";
          hostname = "tank";
          primaryDisplay = "Virtual-1";
          dpi = 220;
          colorscheme = "catppuccin-mocha";
          wallpaper = "evening-sky";
          persistence = true;
          features = [
            "desktop/bspwm"
          ];
        };
        "brenix@dozer" = mkHome {
          username = "brenix";
          hostname = "dozer";
          primaryDisplay = "Virtual-1";
          colorscheme = "nord";
          persistence = true;
          wallpaper = "mountain-jaws";
          features = [
            "desktop/bspwm"
          ];
        };
      };

      deploy.nodes = mkDeploys nixosConfigurations homeConfigurations;
      deployChecks = { };

    };
}
