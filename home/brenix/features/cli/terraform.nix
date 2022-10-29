{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ terraform-docs ];

  home.file.".terraformrc".text = ''
    plugin_cache_dir = "$HOME/.cache/terraform-plugin-cache"
    disable_checkpoint = true
  '';

  systemd.user.tmpfiles.rules = [
    "d %h/.cache/terraform-plugin-cache 0755"
  ];

  home.persistence = {
    "/persist/home/brenix".directories = [ ".terraform.d" ];
  };
}
