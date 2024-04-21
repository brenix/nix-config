{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nixicle; let
  cfg = config.nixicle.system.fonts;
in {
  options.nixicle.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    fonts = {
      fontDir = enabled;

      fonts = with pkgs;
        [
          noto-fonts
          noto-fonts-emoji
          (nerdfonts.override {fonts = ["JetBrainsMono"];})
        ]
        ++ cfg.fonts;
    };
  };
}
