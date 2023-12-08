{ pkgs, ... }:
let
  k3sConfig = pkgs.writeText "k3s-config.yaml" ''
    kubelet-arg:
      - resolv-conf=/run/systemd/resolve/resolv.conf
      - image-gc-high-threshold=50
      - image-gc-low-threshold=30

    kube-controller-manager-arg:
      - terminated-pod-gc-threshold=1

    kube-apiserver-arg:
      - permit-port-sharing=true
      - permit-address-sharing=true

    disable:
      - traefik
      - servicelb
      - local-storage

    disable-network-policy: true
 
    write-kubeconfig-mode: "0644"
  '';
in
{
  services.k3s.enable = true;
  services.k3s.configPath = "${k3sConfig}";

  environment.persistence = {
    "/persist".directories = [
      "/var/openebs"
      "/var/lib/rancher"
    ];
  };
}
