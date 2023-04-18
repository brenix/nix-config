{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ kubectl kubernetes cri-tools ];

  networking.extraHosts = "192.168.1.10 api.kubernetes";

  services.logind.extraConfig = ''
    InhibitDelayMaxSec=60s
  '';

  services.kubernetes = {
    roles = [ "master" "node" ];

    apiserverAddress = "https://api.kubernetes:6443";
    apiserver.advertiseAddress = "192.168.1.10";
    masterAddress = "api.kubernetes";

    # Enable feature gates
    featureGates = [ "MixedProtocolLBService" ];

    # Allow privileged pods
    apiserver.allowPrivileged = true;

    # Always pull images
    apiserver.enableAdmissionPlugins = [ "AlwaysPullImages" ];

    # Additional apiserver flags
    apiserver.extraOpts =
      "--permit-port-sharing=true --permit-address-sharing=true";

    # Use cloudflare certmgr to manage all certs
    easyCerts = true;

    # Kubelet
    kubelet.extraOpts =
      "--resolv-conf=/run/systemd/resolve/resolv.conf --fail-swap-on=false --image-gc-high-threshold=50 --image-gc-low-threshold=30";

    # Enable addon manager
    addonManager.enable = true;

    # CoreDNS
    addons.dns = {
      enable = true;
      replicas = 1;
      corefile = ''
        .:10053 {
            errors
            health :10054 {
                lameduck 5s
            }
            ready
            kubernetes cluster.local in-addr.arpa {
                pods insecure
                fallthrough in-addr.arpa
                ttl 30
            }
            prometheus 0.0.0.0:9153
            forward . 192.168.1.1:53
            cache {
                success 9984 30
                denial 9984 5
                prefetch 3 60s 15%
            }
            loop
            reload
            loadbalance
        }
      '';
    };
  };

  systemd.services = {
    taint-node = {
      description = "Node tainter";
      after = [ "multi-user.target" "kube-apiserver.service" ];
      environment = {
        KUBECONFIG = "/etc/static/kubernetes/cluster-admin.kubeconfig";
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
    };
  };

  environment.persistence = {
    "/persist".directories = [
      "/var/openebs"
      "/var/lib/cfssl"
      "/var/lib/cni"
      "/var/lib/etcd"
      "/var/lib/kubelet"
      "/var/lib/kubernetes"
    ];
  };
}
