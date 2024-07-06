{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  cfg = config.${namespace}.services.netskopeBundler;
  mkBundle = pkgs.writeShellScriptBin "mkBundle.sh" ''
    cacert='/Library/Application Support/Netskope/STAgent/data/'nscacert.pem
    tenantcert='/Library/Application Support/Netskope/STAgent/data/'nstenantcert.pem
    certbundle="${cfg.certPath}"
    if [ -f "$cacert" ] && [ -f "$tenantcert" ]; then
        ${pkgs.coreutils}/bin/echo "$cacert"
        ${pkgs.coreutils}/bin/echo "$tenantcert"

        ${pkgs.coreutils}/bin/echo "Obtaining System Trust Store"
        security find-certificate -a -p /System/Library/Keychains/SystemRootCertificates.keychain > "$certbundle"
        ${pkgs.coreutils}/bin/echo -en "\nNetskope Tenant Certificate" >> "$certbundle"
        ${pkgs.coreutils}/bin/echo -en "\n###########################\n" >> "$certbundle"
        cat "$tenantcert" >> "$certbundle"
        ${pkgs.coreutils}/bin/echo -en "\nNetskope CA Certificate" >> "$certbundle"
        ${pkgs.coreutils}/bin/echo -en "\n###########################\n" >> "$certbundle"
        cat "$cacert" >> "$certbundle"

        if [ $? == 0 ]; then
            ${pkgs.coreutils}/bin/echo "Certificate bundle created"
        else
            ${pkgs.coreutils}/bin/echo "Error!!"
        fi
    else
        ${pkgs.coreutils}/bin/echo "Required certs not found. Please check if Netskope Client is installed"
    fi
  '';
in {
  options.${namespace}.services.netskopeBundler = {
    enable = mkEnableOption ''
      a bundled certificate trust store and update it on login
    '';

    certPath = mkOption {
      default = "/Library/Application Support/Netskope/STAgent/data/netskope-cert-bundle.pem";
      type = types.path;
      description = ''
        Desired location of bundled certificate.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    launchd.agents.netskope-cert-bundler = {
      serviceConfig = {
        Program = "${mkBundle}/bin/mkBundle.sh";
        KeepAlive = false;
        RunAtLoad = true;
        StandardOutPath = "/Library/NetskopeCertBundler/stdout";
        StandardErrorPath = "/Library/Logs/NetskopeCertBundler/stderr";
      };
    };
    environment.variables = {
      REQUESTS_CA_BUNDLE = "${cfg.certPath}";
      SSL_CERT_FILE = "${cfg.certPath}";
      NIX_SSL_CERT_FILE = "${cfg.certPath}";
      NODE_EXTRA_CA_CERTS = "${cfg.certPath}";
    };
    system.activationScripts = {
      netskope-cert-bundler = let
        domain-target = "gui";
      in ''
        /bin/launchctl bootout ${domain-target} /Library/LaunchAgents/org.nixos.netskope-cert-bundler.plist && true
        /bin/launchctl bootstrap ${domain-target} /Library/LaunchAgents/org.nixos.netskope-cert-bundler.plist
      '';
    };
  };
}
