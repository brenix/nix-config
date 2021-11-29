{ config, lib, pkgs, ... }: {

  imports = [
    ./modules/settings.nix
  ];

  # -- BOOTLOADER/KERNEL

  boot = {
    # Default to mainline kernel
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    # Delete all files in `/tmp/` during boot
    cleanTmpDir = true;

    # Use systemd-boot bootloader
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
    };

    # Common sysctl tunings
    kernel = {
      sysctl = {
        "vm.dirty_background_ratio" = 20;
        "vm.dirty_ratio" = 50;
        "vm.swappiness" = 0;
        "vm.vfs_cache_pressure" = 50;
      };
    };
  };

  # -- NIX

  nixpkgs.config.allowUnfree = true;

  nix = {
    package = pkgs.nixFlakes;
    autoOptimiseStore = true;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    gc = {
      automatic = true;
      dates = "daily";
    };
    optimise = {
      automatic = true;
      dates = [ "weekly" ];
    };
  };

  # -- LANGUAGE/TIMEZONE

  time.timeZone = "America/Los_Angeles";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
    font = "Lat2-Terminus16";
  };

  # -- X11

  # Xorg Configuration
  services.xserver = {
    enable = true;
    layout = "us";

    # Fast keyboard response
    autoRepeatDelay = 195;
    autoRepeatInterval = 15;

    # Disable lightdm and allow for startx
    displayManager = {
      startx.enable = true;
    };

    # Remap capslock to escape
    xkbOptions = "caps:escape";
  };

  # -- AUDIO

  # Enable pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # -- USERS

  # brenix
  users.users.${config.settings.username} = {
    isNormalUser = true;
    createHome = true;
    home = "/home/${config.settings.username}";
    description = config.settings.name;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F 20170524-brenix@gmail.com"
    ];
  };

  # -- SERVICES

  # Enable sshd
  services.openssh = {
    enable = true;
    permitRootLogin = "no";
    passwordAuthentication = false;
  };

  # Enable systemd-resolved
  services.resolved.enable = true;

  # Increase tmpfs storage for /run/user/<uid>
  services.logind.extraConfig = ''
    RuntimeDirectorySize=50%
  '';

  # -- FONTS

  # Common fonts to install
  fonts.fonts = with pkgs; [
    corefonts
    cozette
    dejavu_fonts
    dina-font
    gohufont
    hack-font
    liberation_ttf
    noto-fonts
    open-sans
    roboto
    terminus_font
    ubuntu_font_family
    uw-ttyp0
    vistafonts
    weather-icons
    (nerdfonts.override {
      fonts = [
        "Gohu"
        "JetBrainsMono"
        "RobotoMono"
        "UbuntuMono"
      ];
    })
  ];

  # -- PACKAGES

  # Install some common packages
  environment.systemPackages = with pkgs; [
    bash-completion
    bat
    curlie
    delta
    dig
    fd
    fzf
    gcc
    git
    glances
    gnumake
    gnupg
    go
    home-manager
    htop
    lsof
    nmap
    ripgrep
    rsync
    tcpdump
    tmux
    wireguard
    zsh
    zsh-completions
  ];

  # -- SECURITY

  # Prevent replacing the running kernel image
  security.protectKernelImage = true;

  # Dont prompt for sudo password
  security.sudo.wheelNeedsPassword = false;


  # -- NETWORKING

  # Disable firewall
  networking.firewall.enable = false;

  # Enable systemd-networkd
  networking.dhcpcd.enable = false;
  systemd.network.enable = true;

  # Disable DNSSEC for now
  services.resolved.dnssec = "false";

  # Add script for split DNS when connecting to corporate VPN
  environment.etc = {
    "vpnc/post-connect.d/resolved" = {
      text = "resolvectl default-route \${TUNDEV} false";
      mode = "0755";
    };
  };

  # -- SYSTEM
  system = {
    stateVersion = "21.05"; # no touchie
    autoUpgrade = {
      enable = true;
      allowReboot = true;
      flake = "github:brenix/nixos-config";
      flags = [
        "--recreate-lock-file"
        "--no-write-lock-file"
        "-L" # print build logs
      ];
      dates = "daily";
    };
  };
}
