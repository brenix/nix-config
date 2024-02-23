{
  # disable greeting
  fish_greeting = "";

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

  # planapply
  bind_planapply = ''
    commandline -t -- (string replace -a 'plan' 'apply' $history[1])
    commandline -f repaint
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

  # take a screenshot and concatenate the images into one (assumes dual-monitor)
  screenshot = ''
    set -l output (count $argv > /dev/null && echo $argv[1] || echo $HOME/screenshot.png)
    set -l screen1 /tmp/screen1.png
    set -l screen2 /tmp/screen2.png
    import -window root -crop 2560x1440+0+0 $screen1
    import -window root -crop 2560x1440+2560+0 $screen2
    convert -append $screen1 $screen2 $output
    rm $screen1 $screen2
  '';

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

  # display-single
  ds = ''
    if test "$XDG_SESSION_TYPE" = "wayland"
      hyprctl keyword monitor HDMI-A-1,disable
    else
      xrandr --output HDMI-1 --off
    end
  '';


  # display-extend
  de = ''
    if test "$XDG_SESSION_TYPE" = "wayland"
      hyprctl reload
    else
      xrandr --output HDMI-1 --mode 2560x1440 --right-of DP-1
      if test "$DESKTOP_SESSION" = "none+bspwm"
        bspc desktop 3 -m HDMI-1
        bspc desktop 4 -m HDMI-1
        bspc desktop Desktop -r
      end
    end
  '';

  # generate cover label image
  add-cover-label = ''
    set image $argv[1]
    set label $argv[2]
    set fontsize (if test -n "$argv[3]"; echo $argv[3]; else; echo 42; end)

    # resize image
    convert $image \
      -resize "600x600^" \
      -crop 600x600+0+0 +repage \
      -quality 100 \
      (basename $image .jpg)-resized.jpg

    # add label
    convert -background white \
      -gravity east \
      -geometry +0+87 \
      -fill black \
      -pointsize $fontsize \
      -font Inter-Semi-Bold \
      -size 540x95 caption:"$label\ \ " \
      (basename $image .jpg)-resized.jpg \
      +swap \
      -gravity southwest \
      -composite \
      (basename $image .jpg)-labeled.jpg

    rm -f (basename $image .jpg)-resized.jpg
    rm -f (basename $image .jpg)-labeled-0.jpg
    rm -f (basename $image .jpg)-labeled-1.jpg
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
}
