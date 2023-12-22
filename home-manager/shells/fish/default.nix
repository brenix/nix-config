{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.shells.fish;
in
{
  options.modules.shells.fish = {
    enable = mkEnableOption "enable fish shell";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "autopair-fish";
          inherit (pkgs.fishPlugins.autopair-fish) src;
        }
      ];

      shellAliases = {
        bat = "bat --paging=never --style=plain --decorations=never";
        ga = "git add";
        gaa = "git add --all";
        gb = "git branch";
        gba = "git branch --all";
        gc = "git commit --verbose";
        gca = "git commit --verbose --all";
        gco = "git checkout";
        gcl = "git clone --recurse-submodules";
        gd = "git diff";
        gdc = "git diff --cached";
        gl = "git pull --prune";
        glo = "git log --oneline --decorate --pretty=format:'%C(auto)%h %s (%Cgreen%an%C(auto))'";
        gp = "git push";
        gpv = "git push --verbose";
        gpf = "git push --force-with-lease";
        "gpf!" = "git push --force";
        gst = "git status";
        gsh = "git show --format=raw -m";
        grhh = "git reset --hard HEAD";
        l = "ls --format=vertical";
        la = "ls -A --format=vertical";
        mv = "mv -iv";
        rm = "rm -I";
        s = "doas systemctl";
        svim = "doas nvim";
        sw = "git switch";
        virsh = "virsh -c qemu:///system";
        vm = "virsh start windows";
      };

      shellAbbrs = {
        # ave = "aws-vault exec";
        bw = "rbw";
        cat = "bat";
        cm = "cellmate";
        cp = "xcp";
        curl = "curlie";
        dig = "dog";
        fw = "sudo framework_tool --driver=portio";
        grep = "rg";
        k = "kubectl";
        kdd = "kubectl describe deployment";
        kdno = "kubectl describe node";
        kdp = "kubectl describe pod";
        kgcm = "kubectl get configmap";
        kgd = "kubectl get deployment";
        kgds = "kubectl get daemonset";
        kge = "kubectl get events";
        kgno = "kubectl get node";
        kgns = "kubectl get namespace";
        kgp = "kubectl get pods";
        kgpa = "kubectl get pod -A";
        kgs = "kubectl get service";
        kgsa = "kubectl get serviceaccount";
        kgsec = "kubectl get secret";
        kgss = "kubectl get statefulset";
        kk = "kubectl get pod";
        kl = "kubectl logs";
        kvs = "kubectl view-secret";
        kvsec = "kubectl view-secret";
        ping = "gping";
        t = "todoist";
        ta = "todoist add";
        td = "todoist close";
        tl = "todoist list -f 'today & !p4'";
        to = "todoist list -f '(today | overdue) & p1'";
        tq = "todoist quick";
        v = "hx";
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
        # Paths
        ''
          set -gx PATH $PATH $HOME/.krew/bin $GOPATH/bin
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
        # Bindings
        ''
          bind \ce end-of-line
          bind ! bind_bang
          bind '$' bind_dollar
          bind \er bind_planapply
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
        # AWS CLI completions (https://github.com/aws/aws-cli/issues/1079)
        ''
          complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
        '' +
        # Source private files
        ''
          for file in ~/.config/fish/conf.local.d/*.fish
            source $file
          end
        '';
    };

    # Create dirs required by shell
    systemd.user.tmpfiles.rules = [
      "d %h/.kube 0700"
    ];

    home.persistence = {
      "/persist/home/brenix" = {
        directories = [
          ".config/fish/conf.local.d"
          ".local/share/fish"
        ];
        allowOther = true;
      };
    };
  };
}
