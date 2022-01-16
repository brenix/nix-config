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
    # Disable addon manager
    addonManager.enable = false;

    # Enable CoreDNS
    addons.dns.enable = true;

    # Kubelet
    kubelet.extraOpts = "--fail-swap-on=false";
  };

  # Create k8s@home user/group
  users.users.kah = {
    uid = 568;
    group = "kah";
    isNormalUser = true;
    createHome = false;
  };

  users.groups.kah = { gid = 568; };
}

