{ pkgs, lib, persistence, ... }:
{
  environment.systemPackages = with pkgs; [ helm helmfile kubectl kubernetes ];

  networking.extraHosts = "192.168.1.10 api.kubernetes";

  services.kubernetes = {
    roles = [ "master" "node" ];

    apiserverAddress = "https://api.kubernetes:6443";
    apiserver.advertiseAddress = "192.168.1.10";
    masterAddress = "api.kubernetes";

    # Enable feature gates
    featureGates = [ "MixedProtocolLBService" ];

    # Allow privileged pods
    apiserver.allowPrivileged = true;

    # Additional apiserver flags
    apiserver.extraOpts =
      "--permit-port-sharing=true --permit-address-sharing=true";

    # Disable addon manager
    addonManager.enable = false;

    # Use cloudflare certmgr to manage all certs
    easyCerts = true;

    # Kubelet
    kubelet.extraOpts =
      "--resolv-conf=/run/systemd/resolve/resolv.conf --fail-swap-on=false";

    # CoreDNS
    addons.dns = {
      enabled = true;
      replicas = 1;
      corefile = ''
        .:53 {
            errors
            health {
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

  # Create k8s@home user/group
  users.users.kah = {
    uid = 568;
    group = "kah";
    isNormalUser = true;
    createHome = false;
  };

  users.groups.kah = { gid = 568; };

  environment.persistence = lib.mkIf persistence {
    "/persist".directories = [
      "/var/openebs"
      "/var/lib/cfssl"
      "/var/lib/cni"
      "/var/lib/containerd"
      "/var/lib/etcd"
      "/var/lib/kubelet"
      "/var/lib/kubernetes"
    ];
  };
}
