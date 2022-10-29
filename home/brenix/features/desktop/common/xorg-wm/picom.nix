{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    shadow = true;
    fade = false;
    backend = "glx";
    opacityRules = [
      "93:class_i ?= 'alacritty'"
      "93:class_i ?= 'floating'"
      "93:class_i ?= 'polybar'"
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
