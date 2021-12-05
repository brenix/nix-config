{
  description = "NixOS configuration";

  # -- INPUTS

  inputs = {
    # Install bleeding edge updates
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # NixOS hardware profiles
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix user repository
    nur = {
      url = "github:nix-community/NUR";
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

  outputs = inputs@{ self, nixpkgs, home-manager, nur, ... }:
    let
      system = "x86_64-linux";
      # Add nixpkgs overlays and config here. They apply to system and home-manager builds.
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.permittedInsecurePackages = [
          # needed for authy to work
          "electron-9.4.4"
        ];
        overlays = [
          nur.overlay
          ./overlays/freetype.nix
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
            ./config/common
            ./config/openconnect.nix
            ./config/pipewire.nix
            ./config/xorg.nix

            # home-manager configuration
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.brenix = import ./user.nix
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
            # TBD
          ];
        tank = mkHost
          ./hosts/tank.nix
          [
            # TBD
          ];
        neo = mkHost
          ./hosts/neo.nix
          [
            # Hardware profiles from: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
            inputs.nixos-hardware.nixosModules.common-cpu-amd
            inputs.nixos-hardware.nixosModules.common-pc-ssd
            inputs.nixos-hardware.nixosModules.common-gpu-nvidia

            ./config/libvirt.nix
          ];
      };

      # non-NixOS systems
      #homeConfigurations =
      #  let
      #    username = "brenix";
      #    baseConfiguration = {
      #      programs.home-manager.enable = true;
      #      home.username = "brenix";
      #      home.homeDirectory = "/home/brenix";
      #    };
      #    mkHomeConfig = cfg: home-manager.lib.homeManagerConfiguration {
      #      inherit username system;
      #      homeDirectory = "/home/${username}";
      #      configuration = baseConfiguration // cfg;
      #    };
      #  in
      #  {
      #    "FIXME" = mkHomeConfig {
      #      programs.git = import ./home/git.nix;
      #      programs.tmux = import ./home/tmux.nix;
      #    };
      #  };
    };

}
