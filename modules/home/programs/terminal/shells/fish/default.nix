{
  config,
  host,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.shells.fish;
in {
  options.${namespace}.programs.terminal.shells.fish = {
    enable = mkBoolOpt false "enable fish shell";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      # catppuccin.enable = true;

      shellAliases = {
        bat = "bat --paging=never --style=plain --decorations=never";
        g = "git";
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
        gmt = "go mod tidy";
        kubectl = "kubecolor";
        l = "ls -l";
        la = "ls -Al";
        mkdir = "mkdir -p";
        mv = "mv -iv";
        rm = "rm -I";
        sw = "git switch";
        virsh = "virsh -c qemu:///system";
        vm = "virsh start windows";
      };

      shellAbbrs = {
        bw = "rbw";
        calc = "qalc";
        cat = "bat";
        curl = "curlie";
        hmr = "home-manager generations | fzf --tac --no-sort | awk '{print $7}' | xargs -I{} bash {}/activate";
        hms = "home-manager switch --flake ~/nix-config#${config.${namespace}.user.name}@${host}";
        kdd = "kubectl describe deployment";
        kdno = "kubectl describe node";
        kdp = "kubectl describe pod";
        kgcm = "kubectl get configmap";
        kgd = "kubectl get deployment";
        kgds = "kubectl get daemonset";
        kge = "kubectl get events";
        kgno = "kubectl get node";
        kgns = "kubectl get namespace";
        kgpa = "kubectl get pod -A";
        kgp = "kubectl get pods";
        kgsa = "kubectl get serviceaccount";
        kgsec = "kubectl get secret";
        kgs = "kubectl get service";
        kgss = "kubectl get statefulset";
        kk = "kubectl get pod";
        k = "kubectl";
        kl = "kubectl logs";
        kvsec = "kubectl-view-secret";
        kvs = "kubectl-view-secret";
        nd = "nix develop";
        nfu = "nix flake update";
        nhh = "nh home switch";
        nho = "nh os switch";
        nhu = "nh os --update";
        niso = "nix build .#nixosConfigurations.iso.config.system.build.isoImage";
        nrs = "sudo nixos-rebuild switch --flake ~/nix-config#${host}";
        replace = "ambr";
        v = "hx";
      };

      plugins = [
        {
          name = "autopair-fish";
          inherit (pkgs.fishPlugins.autopair-fish) src;
        }
        {
          name = "bass";
          inherit (pkgs.fishPlugins.bass) src;
        }
      ];

      functions = import ./functions.nix;

      interactiveShellInit =
        # Use zoxide
        ''
          if command -sq zoxide
            zoxide init fish | source
            alias cd 'z'
          end
        ''
        +
        # Paths
        ''
          set -gx PATH $PATH $HOME/.local/bin $HOME/.krew/bin $GOPATH/bin
        ''
        +
        # Completions
        ''
          complete -c ssh-multi -w ssh
        ''
        +
        # Bindings
        ''
          bind \ce end-of-line
          bind ! bind_bang
          bind '$' bind_dollar
          bind -k nul 'zi && commandline --function repaint'
        ''
        +
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
        ''
        +
        # Source private files
        ''
          for file in ~/.config/fish/conf.local.d/*.fish
            source $file
          end
        '';
    };
  };
}
