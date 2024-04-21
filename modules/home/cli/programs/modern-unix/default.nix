{ pkgs
, config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.programs.modern-unix;
in
{
  options.cli.programs.modern-unix = with types; {
    enable = mkBoolOpt false "Whether or not to enable modern unix tools";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # broot
      # chafa
      # choose
      curlie
      # dogdns
      # du-dust
      # duf
      dysk
      # entr
      # erdtree
      fd
      # gdu
      # gping
      # hexyl
      # hyperfine
      jqp
      ouch
      # procs
      # psensor
      ripgrep
      sd
      # silver-searcher
      yq-go
    ];
  };
}
