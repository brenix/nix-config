# automatically remove duplicates from these arrays
typeset -U path PATH cdpath CDPATH fpath FPATH manpath MANPATH

# add dirs to path
path=(
  $HOME/.cargo/bin
  $HOME/.krew/bin
  $HOME/.node_modules/bin
  $HOME/bin
  $HOME/.local/bin
  $HOME/go/bin
  /usr/local/bin
  /usr/local/sbin
  $path[@]
)

# override with gnu core utils (darwin)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PATH=/usr/local/opt/coreutils/libexec/gnubin:/usr/local/opt/make/libexec/gnubin:/usr/local/opt/findutils/libexec/gnubin:/usr/local/opt/gnu-sed/libexec/gnubin:/usr/local/opt/grep/libexec/gnubin:${PATH}
fi
