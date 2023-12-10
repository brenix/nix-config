{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    k0s
    k0sctl
  ];

  # environment.etc."cni/net.d/10-flannel.conflist".text = ''
  #   {
  #     "name": "cbr0",
  #     "cniVersion": "0.3.1",
  #     "plugins": [
  #       {
  #         "type": "flannel",
  #         "delegate": {
  #           "hairpinMode": true,
  #           "isDefaultGateway": true
  #         }
  #       },
  #       {
  #         "type": "portmap",
  #         "capabilities": {
  #           "portMappings": true
  #         }
  #       }
  #     ]
  #   }
  # '';


  # systemd.services.k0scontroller = {
  #   description = "k0s - Zero Friction Kubernetes";
  #   documentation = [ "https://docs.k0sproject.io" ];
  #   path = with pkgs; [
  #     # It wants to use "modprobe" to load kernel modules
  #     kmod
  #     # Using "mount"
  #     util-linux
  #   ];
  #   after = [ "network-online.target" ];
  #   wants = [ "network-online.target" ];
  #   wantedBy = [ "multi-user.target" ];
  #   startLimitIntervalSec = 5;
  #   startLimitBurst = 10;
  #   serviceConfig = {
  #     RestartSec = 120;
  #     Delegate = "yes";
  #     KillMode = "process";
  #     LimitCORE = "infinity";
  #     TasksMax = "infinity";
  #     TimeoutStartSec = 0;
  #     LimitNOFILE = 999999;
  #     Restart = "always";
  #     ExecStart = "${pkgs.k0s}/bin/k0s controller --config=/etc/k0s/k0s.yaml --data-dir=/var/lib/k0s --single=true";
  #   };
  #   unitConfig = {
  #     ConditionFileIsExecutable = "/usr/local/bin/k0s";
  #   };
  # };
}
