{ config, pkgs, ...}: {

  let
    kubeControllerIP = "10.96.0.1";
    kubeControllerHostname = "kubernetes";
    kubeControllerAPIServerPort = 6443;
  in
  {
    # resolve master hostname
    networking.extraHosts = "${kubeControllerIP} ${kubeControllerHostname}";

    # packages for administration tasks
    environment.systemPackages = with pkgs; [
      helm
      helmfile
      kubectl
      kubernetes
      kustomize
    ];

    services.kubernetes = {
      roles = ["master" "node"];
      masterAddress = kubeControllerHostname;
      apiserverAddress = "https://${kubeControllerHostname}:${toString kubeControllerAPIServerPort}";
      easyCerts = true;
      apiserver = {
        securePort = kubeControllerAPIServerPort;
        advertiseAddress = kubeControllerIP;
      };

      # use coredns
      addons.dns.enable = true;

      # needed if you use swap
      kubelet.extraOpts = "--fail-swap-on=false";
    };
  }

}
