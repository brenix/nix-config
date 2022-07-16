{ inputs, ... }:
let
  inherit (inputs) self home-manager nixpkgs deploy-rs;
  inherit (self) outputs;

  inherit (builtins) elemAt match any mapAttrs attrValues attrNames listToAttrs;
  inherit (nixpkgs.lib) nixosSystem filterAttrs genAttrs systems mapAttrs';
  inherit (home-manager.lib) homeManagerConfiguration;

  activate = system: deploy-rs.lib.${system}.activate;

  mylib = rec {
    # Applies a function to a attrset's names, while keeping the values
    mapAttrNames = f: mapAttrs' (name: value: { name = f name; inherit value; });

    getUsername = string: elemAt (match "(.*)@(.*)" string) 0;
    getHostname = string: elemAt (match "(.*)@(.*)" string) 1;

    has = element: any (x: x == element);

    forAllSystems = genAttrs systems.flakeExposed;

    importAttrset = path: mapAttrs (_: import) (import path);

    mkSystem =
      { hostname
      , system
      , persistence ? false
      }:
      nixosSystem {
        inherit system;
        pkgs = outputs.legacyPackages.${system};
        specialArgs = {
          inherit mylib inputs outputs hostname persistence;
        };
        modules = attrValues (import ../modules/nixos) ++ [
          ../hosts/${hostname}
        ];
      };

    mkHome =
      { username
      , hostname ? null
      , system ? outputs.nixosConfigurations.${hostname}.pkgs.system
      , persistence ? false
      , colorscheme ? null
      , wallpaper ? null
      , desktop ? null
      , features ? [ ]
      , dpi ? 96
      , primaryDisplay ? null
      , secondaryDisplay ? null
      }:
      homeManagerConfiguration {
        pkgs = outputs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit mylib inputs outputs hostname username persistence
            colorscheme wallpaper desktop features dpi primaryDisplay secondaryDisplay;
        };
        modules = attrValues (import ../modules/home-manager) ++ [
          ../home/${username}
        ];
      };

    mkDeploys = nixosConfigs: homeConfigs:
      let
        nixosProfiles = mapAttrs mkNixosDeployProfile nixosConfigs;
        homeProfiles = mapAttrs mkHomeDeployProfile homeConfigs;
        hostnames = attrNames nixosProfiles;

        homesOn = hostname: filterAttrs (name: _: (getHostname name) == hostname) homeProfiles;
        systemOn = hostname: { system = nixosProfiles.${hostname}; };
        profilesOn = hostname: (systemOn hostname) // (mapAttrNames getUsername (homesOn hostname));
      in
      listToAttrs (map
        (hostname: {
          name = hostname;
          value = {
            inherit hostname;
            profiles = profilesOn hostname;
          };
        })
        hostnames);


    mkNixosDeployProfile = _name: config: {
      user = "root";
      path = (activate config.pkgs.system).nixos config;
    };

    mkHomeDeployProfile = name: config: {
      user = getUsername name;
      path = (activate config.pkgs.system).home-manager config;
    };
  };
in
mylib
