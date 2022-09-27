if [[ $commands[rg] ]] && [[ $commands[sd] ]]; then
  # find and replace text in current path
  replace() {
    ug -l "$1" | xargs sd $1 $2
  }
fi
