{ pkgs
, lib
, config
, host
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.shells.fish;
in
{
  options.cli.shells.fish = with types; {
    enable = mkBoolOpt false "enable fish shell";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      catppuccin.enable = true;
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
        kubectl = "kubecolor";
        l = "ls --format=vertical";
        la = "ls -A --format=vertical";
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
        grep = "rg";
        hmr = "home-manager generations | fzf --tac --no-sort | awk '{print $7}' | xargs -I{} bash {}/activate";
        hms = "home-manager switch --flake ~/nix-config#${config.nixicle.user.name}@${host}";
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
        kvsec = "kubectl view-secret";
        kvs = "kubectl view-secret";
        nd = "nix develop";
        nfu = "nix flake update";
        nhh = "nh home switch";
        nho = "nh os switch";
        nhu = "nh os --update";
        niso = "nix build .#nixosConfigurations.iso.config.system.build.isoImage";
        nrs = "sudo nixos-rebuild switch --flake ~/nix-config#${host}";
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
        {
          name = "fzf-fish";
          inherit (pkgs.fishPlugins.fzf-fish) src;
        }
        {
          name = "nix.fish";
          # TODO: Remove once merged upstream: https://github.com/kidonng/nix.fish/pull/2
          src = pkgs.fetchFromGitHub {
            owner = "Animeshz";
            repo = "nix.fish";
            rev = "a3256cf49846ee4de072c3a9af7a58aad4021693";
            sha256 = "sha256-3M0dU30SrdjInp6MWEC0q7MTInrZNtY6Z9mhBw43PKs=";
          };
        }
      ];
    };
  };
}
