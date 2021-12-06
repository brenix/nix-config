identities=()
for i in $HOME/.ssh/id_(*~*pub); do
    identities+=${i##*/}
done
zstyle :omz:plugins:ssh-agent identities ${identities[@]}

zcomet load ohmyzsh plugins/ssh-agent
