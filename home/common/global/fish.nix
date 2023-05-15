{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      { name = "grc"; inherit (pkgs.fishPlugins.grc) src; }
      { name = "fzf-fish"; inherit (pkgs.fishPlugins.fzf-fish) src; }
      { name = "autopair-fish"; inherit (pkgs.fishPlugins.autopair-fish) src; }
      {
        name = "cd-gitroot";
        src = pkgs.fetchFromGitHub {
          owner = "mollifier";
          repo = "fish-cd-gitroot";
          rev = "9b5c3732655ee99aefae04739242d6a1bab47be1";
          sha256 = "sha256-oc51I50LgsiL5NW1Quf990d8YQgcAmRqgVfPQcIOU1s=";
        };
      }
      {
        name = "kubectl";
        src = pkgs.fetchFromGitHub {
          owner = "blackjid";
          repo = "plugin-kubectl";
          rev = "f3cc9003077a3e2b5f45e3988817a78e959d4131";
          sha256 = "sha256-ABzVSzM135UeAJ97CUBb9rhK9Pc6ItLSmJQOacq09gQ=";
        };
      }
      {
        name = "git";
        src = pkgs.fetchFromGitHub {
          owner = "jhillyerd";
          repo = "plugin-git";
          rev = "1697adf8861a15178f4794de566d14d295c79b39";
          sha256 = "sha256-tsw+npcOga8NBM1F8hnsT69k33FS5nK1zaPB1ohasPk=";
        };
      }
    ];
    shellAbbrs = {
      bw = "rbw";
      kk = "kubectl get pod";
      kvs = "kubectl view-secret";
      v = "nvim";
    };
    shellAliases = {
      ave = "aws-vault exec";
      cat = "bat --paging=never --style=plain --decorations=never";
      cdu = "cd-gitroot";
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      cp = "cp -riv";
      docker = "podman";
      gl = "git pull --prune --tags --force";
      grep = "grep --color=auto";
      l = "ls --format=vertical";
      la = "ls -A --format=vertical";
      mkdir = "mkdir -vp";
      ms = "mullvad status";
      mv = "mv -iv";
      rm = "rm -I";
      s = "doas systemctl";
      svim = "doas nvim";
      sw = "git switch";
      virsh = "virsh -c qemu:///system";
      vm = "virsh start windows";
    };
    functions = {
      # Disable greeting
      fish_greeting = "";
      replace = "rg -l $argv[1] | xargs sd $argv[1] $argv[2]";
      screenshot = ''
        set -l output (count $argv > /dev/null && echo $argv[1] || echo $HOME/screenshot.png)
        set -l screen1 /tmp/screen1.png
        set -l screen2 /tmp/screen2.png
        import -window root -crop 2560x1440+0+0 $screen1
        import -window root -crop 2560x1440+2560+0 $screen2
        convert -append $screen1 $screen2 $output
        rm $screen1 $screen2
      '';
      ssh-multi = ''
        if test -p /dev/stdin
            set -l hosts (cat)
        else if test (count $argv) -ge 1
            set -l hosts $argv
        else
            echo "usage: $argv[0] HOST1 HOST2 ..."
            return
        end

        tmux new-window "ssh $hosts[1]"
        set -l hosts $hosts[2..-1]

        for i in $hosts
            tmux split-window -v "ssh $i"
            tmux select-layout even-vertical > /dev/null
        end

        tmux select-pane -t 0
        tmux set-window-option synchronize-panes on > /dev/null
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
        if not which fzf >/dev/null 2>&1
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
        if not which fzf >/dev/null 2>&1
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
        if not which fzf >/dev/null 2>&1
            echo "please install fzf: github.com/junegunn/fzf" >&2
            return 1
        end
        set selected (find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -exec basename {} \; | fzf -0 -1 --reverse)
        if not test -z $selected
            set -x KUBECONFIG $HOME/.kube/$selected
        end
      '';

      ssh-nodes = ''
        ssh-multi (kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' $argv)
      '';

      ds = ''
        if test "$XDG_SESSION_TYPE" = "wayland"
          hyprctl keyword monitor HDMI-A-1,disable
        else
          xrandr --output HDMI-1 --off
        end
      '';


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

      scale-asg = ''
        set asgs $argv
        if test -z "$AWS_VAULT"
          echo "aws-vault environment not found"
          return 1
        end

        for asg in $asgs
          set name (echo $asg | awk -F= '{print $1}')
          set count (echo $asg | awk -F= '{print $2}')
          awless list scalinggroups --no-headers --format tsv --columns name --filter name=$name | xargs -I % awless --no-sync update scalinggroup -f name=% desired-capacity=$count
        end
      '';

      list-asg = ''
        set pattern $argv[1]
        if test -z "$AWS_VAULT"
          echo "aws-vault environment not found"
        else
          awless list scalinggroups --filter name=$pattern --columns name,desiredcapacity
        end
      '';

    };
    interactiveShellInit =
      # Include local dirs
      ''
        set -gx fish_user_paths ~/.config/fish/conf.local.d
      '' +
      # Use zoxide
      ''
        zoxide init fish | source
      '' +
      # Set kubeconfig var
      ''
        for line in (find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -print)
          set -x KUBECONFIG "$KUBECONFIG:$line"
        end
      '' +
      # Bindings
      ''
        bind \ce forward-char
      '' +
      # Use terminal colors
      ''
        set -U fish_color_autosuggestion      brblack
        set -U fish_color_cancel              -r
        set -U fish_color_command             brgreen
        set -U fish_color_comment             brmagenta
        set -U fish_color_cwd                 green
        set -U fish_color_cwd_root            red
        set -U fish_color_end                 brmagenta
        set -U fish_color_error               brred
        set -U fish_color_escape              brcyan
        set -U fish_color_history_current     --bold
        set -U fish_color_host                normal
        set -U fish_color_match               --background=brblue
        set -U fish_color_normal              normal
        set -U fish_color_operator            cyan
        set -U fish_color_param               brblue
        set -U fish_color_quote               yellow
        set -U fish_color_redirection         bryellow
        set -U fish_color_search_match        'bryellow' '--background=brblack'
        set -U fish_color_selection           'white' '--bold' '--background=brblack'
        set -U fish_color_status              red
        set -U fish_color_user                brgreen
        set -U fish_color_valid_path          --underline
        set -U fish_pager_color_completion    normal
        set -U fish_pager_color_description   yellow
        set -U fish_pager_color_prefix        'white' '--bold' '--underline'
        set -U fish_pager_color_progress      'brwhite' '--background=cyan'
      '' +
      # Source private files
      ''
        for file in ~/.config/fish/conf.local.d/*.fish
          source $file
        end
      '';
  };
  home.persistence = {
    "/persist/home/brenix" = {
      directories = [
        ".config/fish/conf.local.d"
      ];
      allowOther = true;
    };
  };
}
