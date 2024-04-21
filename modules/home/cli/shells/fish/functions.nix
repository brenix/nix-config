{pkgs, ...}: {
  programs.fish.functions = {
    fish_greeting = '''';

    fish_command_not_found = ''
      # If you run the command with comma, running the same command
      # will not prompt for confirmation for the rest of the session
      if contains $argv[1] $__command_not_found_confirmed_commands
        or ${pkgs.gum}/bin/gum confirm --selected.background=2 "Run using comma?"

        # Not bothering with capturing the status of the command, just run it again
        if not contains $argv[1] $__command_not_found_confirmed_commands
          set -ga __fish_run_with_comma_commands $argv[1]
        end

        comma -- $argv
        return 0
      else
        __fish_default_command_not_found_handler $argv
      end
    '';

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
    cdu = ''
      set -l root_path (git rev-parse --show-toplevel)
      builtin cd $root_path
    '';

    # bash export command
    export = ''
      set var1 (echo $argv | cut -f1 -d=)
      set var2 (echo $argv | cut -f2 -d=)
      set -x -g $var1 $var2
    '';

    # replace a given string across files matching a pattern
    replace = "rg -l $argv[1] | xargs sd $argv[1] $argv[2]";

    # switch-namespace
    kns = ''
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
    ktx = ''
      set kubeconfig
      set selected
      if not command -sq fzf
        echo "please install fzf: github.com/junegunn/fzf" >&2
        return 1
      end
      set selected (find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -exec basename {} \; | fzf -0 -1 --reverse)
      if not test -z $selected
        set -x KUBECONFIG $HOME/.kube/$selected
      end
    '';

    # ssh to multiple hosts in tmux panes
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

      tmux new-window -n "$target" "ssh $hosts[1]"

      for host in $hosts[2..-1]
        tmux split-window -t :"$target" -v "ssh $host"
        tmux select-layout -t :"$target" even-vertical >/dev/null
      end

      tmux select-pane -t 0
      tmux set-window-option synchronize-panes on
    '';

    # ssh to multiple k8s nodes in tmux panes
    ssh-nodes = ''
      set -l hosts (string split " " (kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' "$argv"))
      ssh-multi $hosts
    '';
  };
}
