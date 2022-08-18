{ config, ... }:
let
  inherit (config.colorscheme) colors;
in
{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--color=fg:#${colors.base05},bg:#${colors.base01},hl:#${colors.base0B}"
      "--color=fg+:#${colors.base05},bg+:#${colors.base01},hl+:#${colors.base0B}"
      "--color=info:#${colors.base0A},prompt:#${colors.base08},pointer:#${colors.base0E}"
      "--color=marker:#${colors.base0D},spinner:#${colors.base0E},header:#${colors.base0D}"
    ];
  };
}
