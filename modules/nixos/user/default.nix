{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.user;
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  options.user = with types; {
    name = mkOpt str "brenix" "The name of the user's account";
    initialPassword =
      mkOpt str "1"
      "The initial password to use";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs {}
      "Extra options passed to users.users.<name>";
  };

  config = {
    users.users.root.hashedPassword = "$6$imPArM8DgR5oP5AF$QzHCgTHqPvTjZe7t6b28Qg.Qhr4LaQeZWSMgQnFA1s5ZsORDIcIybUiiozChMw67/wkaA8u8RD1CMxYQUcrhj/";
    users.mutableUsers = false;
    users.users.brenix =
      {
        isNormalUser = true;
        inherit (cfg) name;
        hashedPassword = "$6$NM641C6TKGPNuZS4$XMSGEVXzzYh9miRoMBGAno9Lo09xw8yUMk8Sot5io/QDncuGsZhuOuwifLEHiD6PYNDzPw81o0my.GIxCRD/11";
        home = "/home/brenix";
        group = "users";
        shell = pkgs.fish;
        extraGroups =
          [
            "audio"
            "input"
            "video"
            "wheel"
          ]
          ++ ifTheyExist [
            "docker"
            "git"
            "i2c"
            "kvm"
            "libvirtd"
            "libvirt"
            "libvirt-qemu"
            "network"
            "plugdev"
            "podman"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
