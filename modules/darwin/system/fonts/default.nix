{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.matrix.system.fonts;
in {
  options.matrix.system.fonts = with types; {
    enable = mkBoolOpt false "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    fonts = {
      packages = with pkgs;
        [
          noto-fonts
          noto-fonts-emoji
          google-fonts
          (nerdfonts.override {fonts = ["JetBrainsMono"];})
        ]
        ++ cfg.fonts;
    };
  };
}
