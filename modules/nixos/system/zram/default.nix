{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.system.zram;
in {
  options.${namespace}.system.zram = {
    enable = mkBoolOpt false "Whether or not to enable zram swap.";
  };

  config = mkIf cfg.enable {
    services.zram-generator = {
      enable = true;
      settings.zram0 = {
        compression-algorithm = "zstd lz4 (type=huge)";
        zram-size = "ram";
        swap-priority = 100;
        fs-type = "swap";
      };
    };
  };
}
