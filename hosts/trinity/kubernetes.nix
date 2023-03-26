{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [ kubectl kubernetes cri-tools nvidia-podman ];

  virtualisation.containerd.settings = {
    plugins."io.containerd.grpc.v1.cri".containerd = {
      default_runtime_name = "nvidia";
    };

    plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia = {
      privileged_without_host_devices = false;
      runtime_engine = "";
      runtime_root = "";
      runtime_type = "io.containerd.runc.v2";
    };

    plugins."io.containerd.grpc.v1.cri".containerd.runtimes.nvidia.options = {
      BinaryName = "${pkgs.nvidia-podman}/bin/nvidia-container-runtime";
    };
  };

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
