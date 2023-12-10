{ pkgs, ... }:
let
  k0sconfig = pkgs.writeText "k0s-config.yaml" ''
    apiVersion: k0s.k0sproject.io/v1beta1
    kind: ClusterConfig
    metadata:
      name: k0s
    spec:
      # kube-apiserver
      api:
        address: 192.168.1.10
        k0sApiPort: 9443
        port: 6443
        sans:
        - 192.168.1.9
        - trinity
        - trinity.lan
        extraArgs:
          permit-port-sharing: "true"
          permit-address-sharing: "true"
          enable-admission-plugins: AlwaysPullImages

      # kube-controller-manager
      controllerManager:
        extraArgs:
          terminated-pod-gc-threshold: "1"

      # kube-scheduler
      scheduler: {}

      # kubelet
      workerProfiles:
        - name: default
          values:
            # https://kubernetes.io/docs/reference/config-api/kubelet-config.v1beta1/#kubelet-config-k8s-io-v1beta1-KubeletConfiguration
            imageGCHighThresholdPercent: 50
            imageGCLowThresholdPercent: 30
            resolvConf: /run/systemd/resolve/resolv.conf
            shutdownGracePeriod: 120s

      # storage
      storage:
        type: kine
        kine:
          dataSource: /var/lib/k0s/db/state.sqlite3

      # network
      network:
        provider: kuberouter
        podCIDR: 10.244.0.0/16
        serviceCIDR: 10.96.0.0/12
        clusterDomain: cluster.local

      # disable telemetry
      telemetry:
        enabled: false
  '';
in
{
  environment.systemPackages = with pkgs; [
    k0s
    k0sctl
  ];

  services.logind.extraConfig = ''
    InhibitDelayMaxSec=60s
  '';

  systemd.services.k0s = {
    description = "k0s - Zero Friction Kubernetes";
    documentation = [ "https://docs.k0sproject.io" ];
    path = with pkgs; [
      # It wants to use "modprobe" to load kernel modules
      kmod
      # Using "mount"
      util-linux
    ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    startLimitIntervalSec = 5;
    startLimitBurst = 10;
    serviceConfig = {
      RestartSec = 120;
      Delegate = "yes";
      KillMode = "process";
      LimitCORE = "infinity";
      TasksMax = "infinity";
      TimeoutStartSec = 0;
      LimitNOFILE = 999999;
      Restart = "always";
      ExecStart = "${pkgs.k0s}/bin/k0s controller --config=${k0sconfig} --data-dir=/var/lib/k0s --single=true";
    };
    unitConfig = {
      ConditionFileIsExecutable = "${pkgs.k0s}/bin/k0s";
    };
  };

  systemd.services = {
    taint-node = {
      description = "Node tainter";
      wantedBy = [ "multi-user.target" ];
      after = [ "network-online.target" "k0s.service" ];
      restartIfChanged = false;
      environment = {
        KUBECONFIG = "/var/lib/k0s/pki/admin.conf";
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

  environment.persistence = {
    "/persist".directories = [
      "/var/openebs"
      "/var/lib/k0s"
    ];
  };
}
