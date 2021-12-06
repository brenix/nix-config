{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    defaultKeymap = "vicmd";

    dotDir = ".zsh.d"

    sessionVariables = {
      GREP_COLOR = "1;31";
      PAGER = "less -inMRF";
    };

    history = {
      save = 10000;
      size = 10000;
      path = "$HOME/.cache/zsh_history";
    };

    shellAliases = {
      ".." = "cd ..";
      cp = "cp -riv";
      mv = "mv -iv";
      cat = "bat --paging=never --style=plain";
      grep = "grep --color=auto";
      mkdir = "mkdir -vp";
      l = "ls -lhv";
      la = "ls -lAvh";
      ls = "ls -v --color=always --group-directories-first";
      v = "nvim";
      vm = "virsh start win10";
    };

    plugins = {
      {
        name = "zsh-aws-vault";
        src = pkgs.fetchFromGithub {
          owner = "blimmer";
          repo = "zsh-aws-vault";
          rev = "master";
        };
      }
      {
        name = "tipz";
        src = pkgs.fetchFromGithub {
          owner = "molovo";
          repo = "tipz";
          rev = "master";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGithub {
          owner = "rupa";
          repo = "z";
          rev = "master";
        };
      }
      {
        name = "cd-gitroot";
        src = pkgs.fetchFromGithub {
          owner = "mollifier";
          repo = "cd-gitroot";
          rev = "master";
        };
      }
    };
  };

}
