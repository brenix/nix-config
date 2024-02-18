{ config, ... }:
{
  programs.fzf = {
    enable = true;
    defaultOptions = [
      "--color=fg:#${config.colorscheme.palette.base05},bg:#${config.colorscheme.palette.base01},hl:#${config.colorscheme.palette.base0B}"
      "--color=fg+:#${config.colorscheme.palette.base05},bg+:#${config.colorscheme.palette.base01},hl+:#${config.colorscheme.palette.base0B}"
      "--color=info:#${config.colorscheme.palette.base0A},prompt:#${config.colorscheme.palette.base08},pointer:#${config.colorscheme.palette.base0E}"
      "--color=marker:#${config.colorscheme.palette.base0D},spinner:#${config.colorscheme.palette.base0E},header:#${config.colorscheme.palette.base0D}"
    ];
  };
}
