{
  config,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.programs.openconnect;
in {
  options.cli.programs.openconnect = with types; {
    enable = mkBoolOpt false "Whether or not to enable openconnect.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openconnect
    ];

    # Split DNS queries
    environment.etc = mkIf config.services.systemd.resolved {
      "vpnc/post-connect.d/resolved" = {
        text = "resolvectl default-route \${TUNDEV} false";
        mode = "0755";
      };

      "openconnect/hipreport.sh".source = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
    };
  };
}
