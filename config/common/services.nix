{ ... }: {

  # Speed up boot
  # https://discourse.nixos.org/t/boot-faster-by-disabling-udev-settle-and-nm-wait-online/6339
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Enable SSH
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Disable X11 askpass
  programs.ssh.askPassword = "";

  # Increase tmpfs storage for /run/user/<uid>
  services.logind.extraConfig = ''
    RuntimeDirectorySize=50%
  '';

}
