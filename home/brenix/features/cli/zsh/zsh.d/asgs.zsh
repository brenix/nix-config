if [[ $commands[aws-vault] && $commands[awless] ]]; then
  scale-asg() {
    local asgs="$@"
    [[ -z ${AWS_VAULT} ]] && echo aws-vault environment not found && return 1

    while read -d ' ' -r asg; do
      IFS='=' read -r name count <<<"$asg"
      awless list scalinggroups --no-headers --format tsv --columns name --filter name=${name} | xargs -I % awless --no-sync update scalinggroup -f name=% desired-capacity=${count}
    done <<<"${asgs} "
  }

  list-asg() {
    local pattern="${1}"
    if [[ -z ${AWS_VAULT} ]]; then
      echo aws-vault environment not found
    else
      awless list scalinggroups --filter name=${pattern} --columns name,desiredcapacity
    fi
  }
fi
