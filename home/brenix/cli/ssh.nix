{ lib, outputs, hostname, persistence, ... }:
let
  inherit (builtins) attrNames concatStringsSep filter;
  notSelf = n: n != hostname;
  hostnames = filter notSelf (attrNames outputs.nixosConfigurations);
in
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/cells/config/*" ];
    matchBlocks = {
      home = {
        host = concatStringsSep " " hostnames;
        forwardAgent = true;
      };
    };
  };

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [ ".ssh" ];
  };
}
