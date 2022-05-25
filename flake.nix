{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
    nix-colors.url = "github:misterio77/nix-colors";
    pre-commit-hooks = { url = "github:cachix/pre-commit-hooks.nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, flake-utils, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
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
        [ self.overlays.default inputs.nur.overlay inputs.neovim-nightly.overlay ];

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

      overlays.default = import ./overlays { inherit inputs; };
    };
}
