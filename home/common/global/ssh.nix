{ lib, outputs, ... }:
let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/cells/config/*" ];
    matchBlocks = {
      home = {
        host = builtins.concatStringsSep " " hostnames;
        hostname = "%h.localdomain";
        forwardAgent = true;
      };
    };
    extraConfig = ''
      AddressFamily inet
    '';
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [ ".ssh" ];
      allowOther = true;
    };
  };
}
