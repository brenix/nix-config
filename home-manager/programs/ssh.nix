{ outputs, ... }:
let
  hostnames = builtins.attrNames outputs.nixosConfigurations;
in
{
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/cells/config/*" ];
    matchBlocks = {
      net = {
        host = builtins.concatStringsSep " " hostnames;
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
