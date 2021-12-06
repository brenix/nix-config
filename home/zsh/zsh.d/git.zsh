if [[ $commands[git] ]]; then
  # git plugin
  zcomet load ohmyzsh plugins/git

  # git-extras plugin
  zcomet load tj/git-extras

  # git-ignore
  zcomet trigger git-ignore laggardkernel/git-ignore

  # cd-gitroot
  zcomet load mollifier/cd-gitroot

  # additional aliases
  alias gi="git-ignore"
  alias sw='git switch'
  alias cdu="cd-gitroot"
fi
