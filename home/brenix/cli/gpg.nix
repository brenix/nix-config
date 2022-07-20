{ pkgs, config, persistence, lib, ... }:
let
  pinentry =
    if config.gtk.enable then {
      package = pkgs.pinentry-gnome;
      name = "gnome3";
    } else {
      package = pkgs.pinentry-curses;
      name = "curses";
    };
in
{
  home.packages = [ pinentry.package ];

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = pinentry.name;
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

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [ ".gnupg" ];
  };

  programs.gpg = {
    enable = true;
  };

}
