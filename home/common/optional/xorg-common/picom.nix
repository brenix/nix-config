{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    shadow = true;
    fade = false;
    backend = "glx";
    opacityRules = [
      "80:class_i ?= 'alacritty'"
    ];
    settings = {
      blur =
        {
          method = "gaussian";
          size = 10;
          deviation = 5.0;
        };
    };
  };
}
