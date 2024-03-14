{
  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
  };

  programs = {
    # Start gpg-agent if it's not running or tunneled in
    # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
    # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
    bash.profileExtra = "gpgconf --launch gpg-agent";
    fish.loginShellInit = "gpgconf --launch gpg-agent";
    zsh.loginExtra = "gpgconf --launch gpg-agent";
  };

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [ ".gnupg" ];
      allowOther = true;
    };
  };

  programs.gpg = {
    enable = true;
  };
}
