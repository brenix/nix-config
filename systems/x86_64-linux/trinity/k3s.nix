{pkgs, ...}: let
  k3sConfig = pkgs.writeText "k3s-config.yaml" ''
    kubelet-arg:
      - resolv-conf=/run/systemd/resolve/resolv.conf
      - image-gc-high-threshold=50
      - image-gc-low-threshold=30
      - serialize-image-pulls=false
      - registry-qps=1

    kube-controller-manager-arg:
      - terminated-pod-gc-threshold=1

    kube-apiserver-arg:
      - permit-port-sharing=true
      - permit-address-sharing=true
      - enable-admission-plugins=AlwaysPullImages

    disable:
      - traefik
      - servicelb

    disable-network-policy: true

    write-kubeconfig-mode: "0644"
  '';
in {
  services.k3s.enable = true;
  services.k3s.configPath = "${k3sConfig}";
  services.k3s.package = pkgs.k3s;

  services.logind.extraConfig = ''
    InhibitDelayMaxSec=60s
  '';

  systemd.services = {
    taint-node = {
      description = "Node tainter";
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "k3s.service"];
      requires = ["network-online.target"];
      restartIfChanged = false;
      environment = {
        KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
      };
      script = ''
        taint() {
          trap - SIGINT SIGTERM
          echo "Tainting node"
          ${pkgs.kubectl}/bin/kubectl taint node trinity node.kubernetes.io/shutdown:NoExecute
          sleep 45
          echo "Done"
        }

        trap taint SIGINT SIGTERM
        echo "Untainting node"
        ${pkgs.kubectl}/bin/kubectl taint node trinity node.kubernetes.io/shutdown:NoExecute- || true
        echo "Awaiting signals"
        sleep infinity & wait $!
      '';
      serviceConfig.Type = "simple";
      serviceConfig.User = "root";
    };
  };

  environment.persistence."/persist" = {
    directories = [
      # "/var/openebs" # not needed as volume is mounted
      "/var/lib/rancher"
    ];
  };
}
