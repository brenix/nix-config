if [[ $commands[kubectl] ]]; then

  alias kk="kubectl get pod"

  # load all kubeconfigs
  find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -print | while read -r line; do
    export KUBECONFIG="$KUBECONFIG:$line"
  done

  # execute command against all contexts
  kall() {
    local contexts=($(kubectl config get-contexts -o name))
    for context in ${contexts[@]}; do
      printf "\e[1;34m#### %-6s ####\e[m\n" ${context}
      bash -c "kubectl --context ${context} $*"
      printf "\n\n"
    done
  }

  # switch-namespace
  kns() {
    local context
    local namespace
    local selected
    if [[ ! -z $1 ]]; then
      kubectl config set-context $(kubectl config current-context) --namespace "$1"
      return 0
    fi
    if [[ ! -x "$(which fzy 2>/dev/null)" ]]; then
      echo "please install fzy: github.com/jhawthorn/fzy" >&2
      return 1
    fi
    context=$(kubectl config current-context)
    selected=$(kubectl get namespaces -o name | cut -d / -f2 | fzy -l 50)
    if [[ ! -z "$selected" ]]; then
      kubectl config set-context "$context" "--namespace=$selected"
    fi
  }

  # switch-context
  sc() {
    local context
    local selected
    if [[ ! -z $1 ]]; then
      if [[ $1 = *"/"* ]]; then
        context=$(echo $1 | cut -d / -f1)
        namespace=$(echo $1 | cut -d / -f2)
        kubectl config use-context $context
        kubectl config set-context $context --namespace=$namespace
        return 0
      fi
      if [[ $1 = *"-"* ]]; then
        context=$(echo $1 | cut -d - -f1)
        namespace=$(echo $1 | cut -d - -f2)
        kubectl config use-context $context
        kubectl config set-context $context --namespace=$namespace
        return 0
      fi
      kubectl config use-context "$1"
      return 0
    fi
    if [[ ! -x "$(which fzy 2>/dev/null)" ]]; then
      echo "please install fzy: github.com/jhawthorn/fzy" >&2
      return 1
    fi
    selected=$(kubectl config get-contexts -o name | fzy -l 50)
    if [[ ! -z "$selected" ]]; then
      kubectl config use-context "$selected"
    fi
  }

  # switch-kubeconfig
  ktx() {
    local kubeconfig
    local selected
    if [[ ! -x "$(which fzy 2>/dev/null)" ]]; then
      echo "please install fzy: github.com/jhawthorn/fzy" >&2
      return 1
    fi

    selected=$(find ${HOME}/.kube -maxdepth 1 \( -type f -o -type l \) -exec basename {} \; | fzy -l 50)
    if [[ ! -z "$selected" ]]; then
      export KUBECONFIG="${HOME}/.kube/$selected"
    fi
  }

  # ssh-nodes executes ssh-multi to a list of given nodes using kubectl args
  ssh-nodes() {
    ssh-multi $(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' $@)
  }

  # use grc to colorize output from kubectl
  kubectl() {
    grc kubectl "$@"
  }

fi
