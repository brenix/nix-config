{
  services.picom = {
    enable = true;
    activeOpacity = 1.0;
    inactiveOpacity = 1.0;
    shadow = true;
    fade = false;
    backend = "glx";
    # opacityRules = [
    #   "90:class_i ?= 'alacritty'"
    #   "90:class_i ?= 'floating'"
    #   "90:class_i ?= 'polybar'"
    # ];
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
