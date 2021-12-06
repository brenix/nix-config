if [[ $commands[tmux] ]]; then
  ssh-multi() {
    if [ -p /dev/stdin ]; then
      hosts=($(cat))
    else
      if [[ "${#@}" -ge 1 ]]; then
        hosts=("$@")
      else
        echo "usage: $0 HOST1 HOST2 ..."
        return
      fi
    fi

    tmux new-window "ssh ${hosts[1]}"
    hosts=(${hosts:1})

    for i in "${hosts[@]}"; do
      tmux split-window -v  "ssh $i"
      tmux select-layout even-vertical > /dev/null
    done

    tmux select-pane -t 0
    tmux set-window-option synchronize-panes on > /dev/null
  }

  # Use ssh completion
  compdef ssh-multi='ssh'
fi
