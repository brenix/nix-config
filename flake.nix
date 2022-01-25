{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    flake-utils.url = "github:gytis-ivaskevicius/flake-utils-plus";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors = { url = "github:misterio77/nix-colors"; };
    neovim-nightly = { url = "github:nix-community/neovim-nightly-overlay"; };
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:

    flake-utils.lib.mkFlake {
      inherit self inputs;

      sharedOverlays =
        [ self.overlay inputs.nur.overlay inputs.neovim-nightly.overlay ];

      channelsConfig.allowUnfree = true;

      channelsConfig.permittedInsecurePackages = [
        # needed for authy to work
        "electron-9.4.4"
      ];

      hostDefaults = {
        modules = [
          inputs.home-manager.nixosModule
          ./modules/settings.nix
          ./home
          ./config/common
        ];
      };

      hosts = {
        tank.modules = [
          ./config/distributed-build.nix
          ./config/openconnect.nix
          ./config/podman.nix
          ./config/xorg.nix
          ./hosts/tank.nix
        ];
        neo.modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./config/distributed-build.nix
          ./config/libvirt
          ./config/node-exporter.nix
          ./config/openconnect.nix
          ./config/pipewire.nix
          ./config/podman.nix
          ./config/ratbagd.nix
          ./config/xorg.nix
          ./hosts/neo.nix
        ];
        trinity.modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./hosts/trinity.nix
        ];
      };

      overlay = import ./overlays { inherit inputs; };
    };
}
