zcomet load junegunn/fzf shell completion.zsh key-bindings.zsh
(( ${+commands[fzf]} )) || ~[fzf]/install --bin

export FZF_DEFAULT_COMMAND='fd'

# theme-iceberg
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#C6C8D1,bg:#060709,hl:#E9B189
#     --color=fg+:#C6C8D1,bg+:#22262E,hl+:#E9B189
#     --color=info:#4c566a,prompt:#91acd1,pointer:#bf616a
#     --color=marker:#ebcb8b,spinner:#4c566a,header:#4c566a'

# theme-mono
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=bw'

# theme-nord
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#191c26,hl:#a3be8b
    --color=fg+:#e5e9f0,bg+:#191c26,hl+:#a3be8b
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#81a1c1,spinner:#b48dac,header:#81a1c1'

# theme-github
# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
#     --color=fg:#1b1f23,bg:#f6f8fa,hl:#005cc5
#     --color=fg+:#1b1f23,bg+:#f6f8fa,hl+:#005cc5
#     --color=info:#959da5,prompt:#1b1f23,pointer:#161f23
#     --color=marker:#0a3069,spinner:#1b1f23,header:#0a3069'
