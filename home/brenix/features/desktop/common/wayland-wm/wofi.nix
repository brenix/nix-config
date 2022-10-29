{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];

  xdg.configFile."wofi/config".text = ''
    columns=1
    allow_images=false
    insensitive=true
    run-always_parse_args=true
    run-cache_file=/dev/null
    run-exec_search=true
  '';
}
