{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ openconnect ];

  # Configure resolved to split DNS queries
  environment.etc = {
    "vpnc/post-connect.d/resolved" = {
      text = "resolvectl default-route \${TUNDEV} false";
      mode = "0755";
    };

    "openconnect/hipreport.sh".source = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

}
