_: {

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    media-session.enable = true;
    pulse.enable = true;
  };

}
