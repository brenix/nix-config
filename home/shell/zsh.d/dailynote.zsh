NOTEDIR=$HOME/notes

dn() {
  local year=$(date +%Y)
  local month=$(date +%m)
  local day=$(date +%d)
  local category=${1:-work}

  pushd ${NOTEDIR} &>/dev/null && git pull && popd &>/dev/null

  # create dir
  mkdir -p "${NOTEDIR}/$category/daily/$year/$month" &>/dev/null
  local note="${NOTEDIR}/$category/daily/$year/$month/$day.md"

  test -f "${note}" && \
    local msg="Updated daily work notes" || \
    echo -e "### ${year}-${month}-${day}\n\n" > "${note}" && \
    local msg="Added daily work notes"

  # edit file
  $EDITOR "${note}"

  # cleanup empty files and dirs
  find "${NOTEDIR}/$category/daily -type d -empty -delete" &>/dev/null
  find "${NOTEDIR}/$category/daily -type f -size 0 -delete" &>/dev/null

  pushd "${NOTEDIR}" >/dev/null
  if [[ -f "${note}" ]]; then
    git add "${note}"
    git commit -m "${msg}"
    git push origin master
  fi
  popd >/dev/null

}

dnc() {
  local year=$(date +%Y)
  local month=$(date +%m)
  local day=$(date +%d)
  local category=${1:-work}
  local note="${NOTEDIR}/$category/daily/$year/$month/$day.md"

  case "$OSTYPE" in
    linux*) bat --color=never --paging=never "${note}" | xclip ;;
    darwin*) bat --color=never --paging=never "${note}" | pbcopy ;;
    *) echo "Unknown OS" ;;
  esac
}
