{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "autopair-fish";
        inherit (pkgs.fishPlugins.autopair-fish) src;
      }
      {
        name = "aws";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-aws";
          rev = "df2ab7f8def99bfcef8c80961d6c9ac0a3108938";
          sha256 = "sha256-9eurNL1cQIIHk9+SmiB8914d2s9RLYGA75fYpbQiBEo=";
        };
      }
      {
        name = "fzf-fish";
        inherit (pkgs.fishPlugins.fzf-fish) src;
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
      # {
      #   name = "grc";
      #   inherit (pkgs.fishPlugins.grc) src;
      # }
      {
        name = "kubectl";
        src = pkgs.fetchFromGitHub {
          owner = "blackjid";
          repo = "plugin-kubectl";
          rev = "f3cc9003077a3e2b5f45e3988817a78e959d4131";
          sha256 = "sha256-ABzVSzM135UeAJ97CUBb9rhK9Pc6ItLSmJQOacq09gQ=";
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
      clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
      cp = "cp -riv";
      docker = "podman";
      gl = "git pull --prune --tags --force";
      gpf = "git push --force-with-lease";
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

    functions = import ./functions.nix;

    interactiveShellInit =
      # Use zoxide
      ''
        if command -sq zoxide
          zoxide init fish | source
        else
          echo "zoxide not installed"
        end
        alias cd 'z'
      '' +
      # Completions
      ''
        complete -c ssh-multi -w ssh
      '' +
      # Set kubeconfig var
      ''
        if command -sq kubectl
          for line in (find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -print)
            set -x KUBECONFIG "$KUBECONFIG:$line"
          end
        end
      '' +
      # Setup grc colorizer since upstream plugin doesnt work properly
      ''
        set -U grc_plugin_execs cat cvs df diff dig gcc ifconfig \
              make mount mtr netstat ping ps tail traceroute \
              wdiff blkid du dnf docker env id ip iostat journalctl kubectl \
              last lsattr lsblk lspci lsmod lsof getfacl getsebool ulimit uptime nmap \
              fdisk findmnt free semanage sar ss sysctl systemctl stat showmount \
              tcpdump tune2fs vmstat w who sockstat

        for executable in $grc_plugin_execs
          if type -q $executable
            function $executable --inherit-variable executable --wraps=$executable
              if isatty 1
                grc $executable $argv
              else
                eval command $executable $argv
              end
            end
          end
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
      # TODO: Re-enable or find alternative solution due to frequent errors
      # files = [
      #   ".local/share/fish/fish_history"
      # ];
      allowOther = true;
    };
  };
}
