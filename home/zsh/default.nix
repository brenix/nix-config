{ config, pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    defaultKeymap = "viins";

    sessionVariables = {
      GREP_COLOR = "1;31";
      PAGER = "less -inMRF";
    };

    completionInit = ''
      autoload -Uz compinit && compinit
      autoload -Uz bashcompinit && bashcompinit
    '';

    history.path = ".cache/zsh_history";

    shellAliases = {
      ave = "aws-vault exec";
      cat = "bat --paging=never --style=plain --decorations=never";
      cd = "z";
      cdi = "zi";
      cdu = "cd-gitroot";
      cp = "cp -riv";
      define = "googler -n 2 define";
      grep = "grep --color=auto";
      l = "ls -lhv";
      la = "ls -lAvh";
      ls = "ls -v --color=always --group-directories-first";
      mkdir = "mkdir -vp";
      mv = "mv -iv";
      q = "googler";
      rm = "rm -I";
      s = "doas systemctl";
      svim = "doas nvim";
      sw = "git switch";
      v = "nvim";
      virsh = "virsh -c qemu:///system";
      vm = "virsh start win10";
    };

    plugins = [
      {
        name = "zsh-autopair";
        src = pkgs.fetchFromGitHub {
          owner = "hlissner";
          repo = "zsh-autopair";
          rev = "9d003fc02dbaa6db06e6b12e8c271398478e0b5d";
          sha256 = "0s4xj7yv75lpbcwl4s8rgsaa72b41vy6nhhc5ndl7lirb9nl61l7";
        };
      }
      {
        name = "cd-gitroot";
        src = pkgs.fetchFromGitHub {
          owner = "mollifier";
          repo = "cd-gitroot";
          rev = "66f6ba7549b9973eb57bfbc188e29d2f73bf31bb";
          sha256 = "00aj9z3fa6ghjpz7s9cdqpfy4vh1v19z284p4f7xj0z40vrlbdx4";
        };
      }
      {
        name = "zsh-aws-vault";
        src = pkgs.fetchFromGitHub {
          owner = "blimmer";
          repo = "zsh-aws-vault";
          rev = "0240d7cd13362353a8c1de0230934c59df81a842";
          sha256 = "0mjk9vkk1h1rfaiwz8ikklqbszcsdccdnihw9341jjl72j31fsnj";
        };
      }
    ];

    initExtraFirst = ''
      # -- OPTIONS
      setopt alwaystoend         # Move cursor to end of word if completed in-word
      setopt appendhistory       # allow multiple sessions to append to history
      setopt autocd              # if a command cant be executed, cd into the dir
      setopt autopushd           # make cd push the old dir onto the dir stack
      setopt bashrematch         # enable bash regex matching
      setopt clobber             # allow files to be clobbered
      setopt completeinword      # not just at the end
      setopt extendedglob        # allow reg-ex style matching
      setopt hashlistall         # hash command paths when completion is attempted
      setopt histexpiredupsfirst # ignore recording duplicate commands
      setopt histignorealldups   # ignore recording duplicate commands
      setopt histignorespace     # ignore recording commands prefixed with a space
      setopt incappendhistory    # write to history file immediately, not when shell exits
      setopt interactivecomments # enable comments on the command line
      setopt menucomplete        # show menu completions
      setopt noautomenu          # bash-like completion
      setopt nobeep              # avoid beeping
      setopt noflowcontrol       # no c-s/c-q output freezing
      setopt nohup               # dont send SIGHUP to background processes when exiting
      setopt null_glob           # dont error when no matching patterns exist when globbing
      setopt promptsubst         # allow expansion in prompts
      setopt pushdignoredups     # dont push the same dir twice
      setopt unset               # dont error out when unset parameters are used
    '';

    initExtra = ''
      # -- COMPLETION

      # HACK: Added because oh-my-zsh doesnt seem to run compinit properly
      autoload -Uz compinit && compinit
      autoload -Uz bashcompinit && bashcompinit

      zstyle ':completion::complete:*' gain-privileges 1
      zstyle ':completion:*' rehash true
      zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'
      zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
      zstyle ":completion:*" completer _expand _complete _ignored _approximate
      zstyle ":completion:*" insert-unambiguous true
      zstyle ":completion:::*:default" menu no select
      zstyle ':completion::complete:*' use-cache 1
      zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

      complete -C ${pkgs.awscli}/bin/aws_completer aws

      # -- PATHS
      fpath=(
        $HOME/.local/share/zsh/site-functions
        $fpath[@]
      )

      # -- KEYBINDINGS
      bindkey "^A" beginning-of-line    # ctrl+a
      bindkey "^E" end-of-line          # ctrl+e
      bindkey "^F" vi-change-whole-line # ctrl+f
      bindkey "^[OF" end-of-line        # end key
      bindkey "^[[4~" end-of-line       # end key (st)
      bindkey "^[OH" beginning-of-line  # home key
      bindkey "^[[H" beginning-of-line  # home key (st)
      bindkey "^[[2~" overwrite-mode    # insert key
      bindkey "^[[4h" overwrite-mode    # insert key (st)
      bindkey "^[[3~" delete-char       # del key
      bindkey "^[[P" delete-char        # del key (st)

      # ctrl+arrows
      bindkey "\e[1;5C" forward-word
      bindkey "\e[1;5D" backward-word
      bindkey "\eOc" forward-word
      bindkey "\eOd" backward-word

      # ctrl+delete
      bindkey "\e[3;5~" kill-word
      bindkey "\e[3^" kill-word

      # ctrl+backspace
      bindkey '^H' backward-kill-word

      # ctrl+shift+delete
      bindkey "\e[3;6~" kill-line
      bindkey "\e[3@" kill-line

      # clear screen
      bindkey "^[d" clear-screen

      # -- SOURCE ADDITIONAL FILES
      source ${pkgs.grc}/etc/grc.zsh
      source /etc/profiles/per-user/$USER/etc/profile.d/asdf-prepare.sh

      for f in $HOME/.zsh.d/*.zsh $HOME/.zsh.local.d/*.zsh; do
        source $f
      done
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "kubectl" "ssh-agent" "zoxide" ];
      extraConfig = ''
        identities=()
        for i in $HOME/.ssh/id_(*~*pub); do
          identities+=''${i##*/}
        done
        zstyle :omz:plugins:ssh-agent identities ''${identities[@]}
      '';

      custom = "$HOME/.oh-my-zsh";
    };

  };

  home.file = {
    ".oh-my-zsh/lib/vcs_info.zsh".text = ""; # Nullify this lib due to upstream bugs
    ".zsh.d".source = ./zsh.d;
    ".zsh.d".recursive = true;
  };

  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = builtins.readFile ./dircolors;

    /* extraConfig = builtins.readFile "${pkgs.fetchurl { */
    /*   url = */
    /*     "https://github.com/arcticicestudio/nord-dircolors/raw/addb3b427e008d23affc721450fde86f27566f1d/src/dir_colors"; */
    /*   sha256 = "sha256-hlezTQqouVKbxgQBxtZU4en0idDiTCRJtFGH6XYFmtc="; */
    /* }}"; */
  };

}

# vim: set ft=nix:
