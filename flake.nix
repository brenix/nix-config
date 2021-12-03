{
  description = "NixOS configuration";

  # -- INPUTS

  inputs = {
    # Install bleeding edge updates
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # NixOS hardware profiles
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Colors manager
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

  # -- OUTPUTS

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
    let

      system = "x86_64-linux";
      # Add nixpkgs overlays and config here. They apply to system and home-manager builds.
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          (import inputs.neovim-nightly-overlay)
        ];
      };
      mkHost = configurationNix: extraModules: nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        # Arguments to pass to all modules.
        specialArgs = { inherit system inputs; };
        modules = (
          [
            # System configuration for this host
            configurationNix

            # Common configuration for all hosts
            ./config/common/sysctl.nix
            ./config/common/services.nix

            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.brenix = import ./home.nix
                {
                  inherit inputs system pkgs;
                };
            }
          ] ++ extraModules
        );
      };

    in

    {
      # The "name" in nixosConfigurations.${name} should match the `hostname`
      nixosConfigurations = {
        dozer = mkHost
          ./hosts/dozer.nix
          [
            #./config/server/harden.nix
            #./config/server/unlaptop.nix
            #./config/server/wakeonlan.nix
            #./config/kde.nix
            #./config/desktopish/guiapps.nix
            #./config/desktopish/fonts.nix
            #./config/protonvpn.nix
            #./config/lxd.nix
            #./config/docker.nix
            #./config/postgres.nix
          ];
        tank = mkHost
          ./hosts/tank.nix
          [
            #./config/server/harden.nix
            #./config/distributed-build.nix
            #./config/gnome.nix
            #./config/desktopish/guiapps.nix
            #./config/desktopish/fonts.nix
            #./config/protonvpn.nix
          ];
        neo = mkHost
          ./hosts/neo.nix
          [
            # Hardware profiles from: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
            nixos-hardware.nixosModules.common-cpu-amd
            nixos-hardware.nixosModules.common-pc-ssd
            nixos-hardware.nixosModules.common-gpu-nvidia

            #./config/server/harden.nix
            #./config/distributed-build.nix
            #./config/gnome.nix
            #./config/desktopish/guiapps.nix
            #./config/desktopish/fonts.nix
            #./config/protonvpn.nix
            #./config/desktopish
          ];
      };

      # non-NixOS systems
      homeConfigurations =
        let
          username = "brenix";
          baseConfiguration = {
            programs.home-manager.enable = true;
            home.username = "brenix";
            home.homeDirectory = "/home/brenix";
          };
          mkHomeConfig = cfg: home-manager.lib.homeManagerConfiguration {
            inherit username system;
            homeDirectory = "/home/${username}";
            configuration = baseConfiguration // cfg;
          };
        in
        {
          "x1c7" = mkHomeConfig {
            programs.git = import ./home/git.nix;
            programs.tmux = import ./home/tmux.nix;
          };
        };
    };

  # -- HOST CONFIGURATIONS


}
