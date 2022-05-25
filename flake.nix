{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
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

  outputs = { self, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
    in

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
          ./config/openconnect.nix
          ./config/podman.nix
          ./config/xorg.nix
          ./hosts/tank.nix
        ];
        neo.modules = [
          inputs.nixos-hardware.nixosModules.common-cpu-amd
          inputs.nixos-hardware.nixosModules.common-pc-ssd
          ./config/android.nix
          ./config/libvirt
          ./config/mullvad.nix
          ./config/node-exporter.nix
          ./config/openconnect.nix
          ./config/pipewire.nix
          ./config/podman.nix
          ./config/ratbagd.nix
          ./config/steam.nix
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
