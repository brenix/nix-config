{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ openconnect ];

  # Add script for split DNS when connecting to corporate VPN
  environment.etc = {
    "vpnc/post-connect.d/resolved" = {
      text = "resolvectl default-route \${TUNDEV} false";
      mode = "0755";
    };

    "openconnect/hipreport.sh".source = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
  };

}
