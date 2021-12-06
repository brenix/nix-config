if [[ commands[bat] ]]; then
  export BAT_THEME="ansi"

  alias cat='bat --color=always --decorations=never --paging=never'
  alias less='less -inMRF'
fi
