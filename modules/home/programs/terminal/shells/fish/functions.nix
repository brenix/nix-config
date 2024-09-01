{
  fish_greeting = '''';

  # emulate !!
  bind_bang = ''
    switch (commandline -t)[-1]
      case "!"
        commandline -t -- $history[1]
        commandline -f repaint
      case "*"
        commandline -i !
    end
  '';

  # emulate $!
  bind_dollar = ''
    switch (commandline -t)[-1]
      case "!"
        commandline -f backward-delete-char history-token-search-backward
      case "*"
        commandline -i '$'
    end
  '';

  # wl-paste
  bind_wlpaste = ''
    commandline -t -- (wl-paste -p -n)
    commandline -f repaint
  '';

  # cd to root of git dir
  cdr = ''
    set -l root_path (git rev-parse --show-toplevel)
    builtin cd $root_path
  '';

  # bash export command
  export = ''
    set var1 (echo $argv | cut -f1 -d=)
    set var2 (echo $argv | cut -f2 -d=)
    set -x -g $var1 $var2
  '';

  # git switch to branch with fzf
  gwf = ''
    git for-each-ref --sort=-committerdate --format='%(refname:short) (%(committerdate:relative))' refs/heads |
      fzf --prompt " " |
      awk '{ print $1 }' |
      xargs git switch
  '';

  # git worktree add
  gwa = ''
    set repo (basename (git rev-parse --show-toplevel))
    set branch (git branch --show-current | string replace -a '/' '-')
    git worktree add ../$repo-$branch
    if command -sq zoxide
      zoxide add ../$repo-$branch
    end
  '';

  # switch-namespace
  kn = ''
    set context
    set namespace
    set selected
    if not test -z $argv[1]
      kubectl config set-context (kubectl config current-context) --namespace $argv[1]
      return 0
    end
    if not command -sq fzf
      echo "please install fzf: github.com/junegunn/fzf" >&2
      return 1
    end
    set context (kubectl config current-context)
    set selected (kubectl get namespaces -o name | cut -d / -f2 | fzf -0 -1 --reverse)
    if not test -z $selected
      kubectl config set-context $context "--namespace=$selected"
    end
  '';

  # switch-context
  sc = ''
    set context
    set selected
    if not test -z $argv[1]
      if echo $argv[1] | grep -q '/'
        set context (echo $argv[1] | cut -d / -f1)
        set namespace (echo $argv[1] | cut -d / -f2)
        kubectl config use-context $context
        kubectl config set-context $context --namespace=$namespace
        return 0
      end
      if echo $argv[1] | grep -q '\-'
        set context (echo $argv[1] | cut -d - -f1)
        set namespace (echo $argv[1] | cut -d - -f2)
        kubectl config use-context $context
        kubectl config set-context $context --namespace=$namespace
        return 0
      end
      kubectl config use-context $argv[1]
      return 0
    end
    if not command -sq fzf
      echo "please install fzf: github.com/junegunn/fzf" >&2
      return 1
    end
    set selected (kubectl config get-contexts -o name | fzf -0 -1 --reverse)
    if not test -z $selected
      kubectl config use-context $selected
    end
  '';

  # switch kubeconfig
  kx = ''
    if not command -sq fzf
      echo "please install fzf: github.com/junegunn/fzf" >&2
      return 1
    end
    set selected (find $HOME/.kube -maxdepth 1 \( -type f -o -type l -not -name '.*' \) -exec basename {} \; | fzf -0 -1 --reverse)
    if not test -z $selected
      set -x -g KUBECONFIG "$HOME/.kube/$selected"
    end
  '';

  # ssh to multiple hosts in zellij panes
  ssh-multi = ''
    set -l hosts
    if test -t 0
      set hosts $argv
    else
      while read -l line
        set --append hosts (string split " " $line)
      end
    end

    set -l target ssh-multi

    if test -n "$TMUX"
      tmux new-window -n "$target" "ssh $hosts[1]"
      for host in $hosts[2..-1]
        tmux split-window -t :"$target" -v "ssh $host"
        tmux select-layout -t :"$target" even-vertical >/dev/null
      end
      tmux select-pane -t 0
      tmux set-window-option synchronize-panes on
    else if test -n "$ZELLIJ"
      set -l layout_file (mktemp)
      printf 'layout {%s}' (string join "" (for host in $hosts; printf 'pane {command "ssh"; args "%s"; close_on_exit true;}; ' $host; end)) >$layout_file
      zellij action new-tab -l $layout_file -n ssh-multi
      zellij action toggle-active-sync-tab
      rm -f $layout_file
    else
      echo 'Neither tmux or zellij are running!'
    end
  '';

  # ssh to multiple k8s nodes in tmux panes
  ssh-nodes = ''
    set -l hosts (string split " " (kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' "$argv"))
    ssh-multi $hosts
  '';

  # yazi function
  zz = ''
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      cd -- "$cwd"
    end
    rm -f -- "$tmp"
  '';
}
