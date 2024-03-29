{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tfenv
    tfsort
    terraform-docs
  ];

  home.file.".terraformrc".text = ''
    plugin_cache_dir = "$HOME/.cache/terraform-plugin-cache"
    disable_checkpoint = true
    plugin_cache_may_break_dependency_lock_file = true
  '';

  systemd.user.tmpfiles.rules = [
    "d %h/.cache/terraform-plugin-cache 0755"
  ];

  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".local/tfenv"
        ".terraform.d"
      ];
      allowOther = true;
    };
  };
}
