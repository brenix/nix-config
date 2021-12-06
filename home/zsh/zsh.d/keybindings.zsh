# -- enable vim mode
bindkey -v

# -- cursor
bindkey "^A" beginning-of-line    # ctrl+a
bindkey "^E" end-of-line          # ctrl+e
bindkey "^F" vi-change-whole-line # ctrl+f

bindkey "^[OF" end-of-line        # end key
bindkey "^[[4~" end-of-line       # end key (st)
bindkey "^[OH" beginning-of-line  # home key
bindkey "^[[H" beginning-of-line  # home key (st)
bindkey "^[[2~" overwrite-mode    # insert key
bindkey "^[[4h" overwrite-mode    # insert key (st)
bindkey "^[[3~" delete-char       # del key
bindkey "^[[P" delete-char        # del key (st)

# -- ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

# -- ctrl+delete
bindkey "\e[3;5~" kill-word
bindkey "\e[3^" kill-word

# -- ctrl+backspace
bindkey '^H' backward-kill-word

# -- ctrl+shift+delete
bindkey "\e[3;6~" kill-line
bindkey "\e[3@" kill-line

# -- clear screen
bindkey "^[d" clear-screen
