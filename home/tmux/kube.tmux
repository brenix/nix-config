#!/usr/bin/env bash

# Default values for the plugin
KUBE_TMUX_BINARY="${KUBE_TMUX_BINARY:-kubectl}"
KUBE_TMUX_DIVIDER="${KUBE_TMUX_DIVIDER-:}"
KUBE_TMUX_KUBECONFIG_CACHE="${KUBECONFIG}"
KUBE_TMUX_UNAME=$(uname)
KUBE_TMUX_LAST_TIME=0

_kube_tmux_binary_check() {
  command -v $1 >/dev/null
}

_kube_tmux_split() {
  type setopt >/dev/null 2>&1 && setopt SH_WORD_SPLIT
  local IFS=$1
  echo $2
}

_kube_tmux_file_newer_than() {
  local mtime
  local file=$1
  local check_time=$2

  if [[ "$KUBE_TMUX_UNAME" == "Linux" ]]; then
    mtime=$(stat -c %Y "${file}")
  elif [[ "$KUBE_TMUX_UNAME" == "Darwin" ]]; then
    # Use native stat in cases where gnutils are installed
    mtime=$(/usr/bin/stat -f %m "$file")
  fi

  [[ "${mtime}" -gt "${check_time}" ]]
}

_kube_tmux_update_cache() {
  if ! _kube_tmux_binary_check "${KUBE_TMUX_BINARY}"; then
    # No ability to fetch context/namespace; display N/A.
    KUBE_TMUX_CONTEXT="BINARY-N/A"
    KUBE_TMUX_NAMESPACE="N/A"
    return
  fi

  if [[ "${KUBECONFIG}" != "${KUBE_TMUX_KUBECONFIG_CACHE}" ]]; then
    # User changed KUBECONFIG; unconditionally refetch.
    KUBE_TMUX_KUBECONFIG_CACHE=${KUBECONFIG}
    _kube_tmux_get_context_ns
    return
  fi

  # kubectl will read the environment variable $KUBECONFIG
  # otherwise set it to ~/.kube/config
  local conf
  for conf in $(_kube_tmux_split : "${KUBECONFIG:-${HOME}/.kube/config}"); do
    [[ -r "${conf}" ]] || continue
    if _kube_tmux_file_newer_than "${conf}" "${KUBE_TMUX_LAST_TIME}"; then
      _kube_tmux_get_context_ns
      return
    fi
  done
}

_kube_tmux_get_context_ns() {
  # Set the command time
  if [[ "${KUBE_TMUX_SHELL}" == "bash" ]]; then
    if ((BASH_VERSINFO[0] >= 4)); then
      KUBE_TMUX_LAST_TIME=$(printf '%(%s)T')
    else
      KUBE_TMUX_LAST_TIME=$(date +%s)
    fi
  fi

  KUBE_TMUX_CONTEXT="$(${KUBE_TMUX_BINARY} config current-context 2>/dev/null)"
  KUBE_TMUX_NAMESPACE="$(${KUBE_TMUX_BINARY} config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)"
}

kube_tmux() {
  _kube_tmux_update_cache

  local KUBE_TMUX

  # Context
  case "${KUBE_TMUX_CONTEXT}" in
    *prod*) KUBE_TMUX+="#[fg=red]${KUBE_TMUX_CONTEXT}" ;;
    [aA-fF]*) KUBE_TMUX+="#[fg=blue]${KUBE_TMUX_CONTEXT}" ;;
    [gG-pP]*) KUBE_TMUX+="#[fg=yellow]${KUBE_TMUX_CONTEXT}" ;;
    [qQ-zZ]*) KUBE_TMUX+="#[fg=red]${KUBE_TMUX_CONTEXT}" ;;
    "") exit ;;
    *) KUBE_TMUX+="#[fg=cyan]${KUBE_TMUX_CONTEXT}" ;;
  esac

  # Namespace
  if [[ -n "${KUBE_TMUX_DIVIDER}" ]]; then
    KUBE_TMUX+="#[fg=${1:-white}]${KUBE_TMUX_DIVIDER}"
  fi
  KUBE_TMUX+="#[fg=${2:-white}]${KUBE_TMUX_NAMESPACE}"

  echo "${KUBE_TMUX}"
}

kube_tmux "$@"
