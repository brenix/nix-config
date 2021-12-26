{ config, pkgs, ... }: {

  environment.systemPackages = with pkgs; [ helm helmfile kubectl kubernetes ];

  services.kubernetes = {
    roles = [ "master" "node" ];

    # TODO: Change these for network-wide access
    apiserverAddress = "https://127.0.0.1:6443";
    masterAddress = "localhost";

    # Use cloudflare certmgr to manage all certs
    easyCerts = true;

    # Addons
    addons.dns.enable = true;

    # Kubelet
    kubelet.extraOpts = "--fail-swap-on=false";
  };
}

