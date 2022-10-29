{ lib, ... }:
let inherit (lib) types mkOption;
in
{
  options.dpi = mkOption {
    type = types.int;
    default = 96;
  };
}
