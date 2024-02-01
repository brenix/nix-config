{ config, ... }:
let
  inherit (config.colorscheme) palette;
in
{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--color=fg:#${palette.base05},bg:#${palette.base01},hl:#${palette.base0B}"
      "--color=fg+:#${palette.base05},bg+:#${palette.base01},hl+:#${palette.base0B}"
      "--color=info:#${palette.base0A},prompt:#${palette.base08},pointer:#${palette.base0E}"
      "--color=marker:#${palette.base0D},spinner:#${palette.base0E},header:#${palette.base0D}"
    ];
  };
}
