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
        hostname = "%h.localdomain";
        forwardAgent = true;
      };
    };
    extraConfig = ''
      AddressFamily inet
    '';
  };

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [ ".ssh" ];
  };
}
