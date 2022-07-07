{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    pre-commit-hooks = { url = "github:cachix/pre-commit-hooks.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
    firefox-nightly = { url = "github:colemickens/flake-firefox-nightly"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, flake-utils, firefox-nightly, nix-colors, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      firefox-nightly-overlay = final: prev: {
        inherit (firefox-nightly.packages.${prev.system}.firefox-nightly-bin) firefox-nightly-bin;
      };
    in

    flake-utils.lib.mkFlake {
      inherit self inputs;

      devShells.${system}.default = pkgs.mkShell {
        packages = [ pkgs.nixpkgs-fmt ];
        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };

      checks.${system}.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = self;
        hooks.nixpkgs-fmt.enable = true;
        hooks.shellcheck.enable = true;
      };

      sharedOverlays =
        [ self.overlays.default inputs.nur.overlay inputs.neovim-nightly.overlay firefox-nightly-overlay ];

      channelsConfig.allowUnfree = true;

      channelsConfig.permittedInsecurePackages = [
        # needed for authy to work
        "electron-9.4.4"
      ];

      hostDefaults = {
        modules = [
          inputs.home-manager.nixosModule
          ./home
          ./config/common
        ];
        specialArgs = {
          inherit nix-colors;
        };
      };

      hosts = {
        tank.modules = [
          ./config/openconnect.nix
          ./config/podman.nix
          ./config/xserver.nix
          ./hosts/tank.nix
        ];
        neo.modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./config/libvirt
          ./config/node-exporter.nix
          ./config/openconnect.nix
          ./config/pipewire.nix
          ./config/podman.nix
          ./config/ratbagd.nix
          ./config/xserver.nix
          ./hosts/neo.nix
        ];
        trinity.modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./hosts/trinity.nix
        ];
      };

      overlays.default = import ./pkgs { inherit inputs; };
    };
}
