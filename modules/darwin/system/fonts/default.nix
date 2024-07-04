{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
with lib; let
  cfg = config.${namespace}.system.fonts;
in {
  options.${namespace}.system.fonts = with types; {
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
