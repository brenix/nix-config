{ pkgs, ... }: {

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;

    defaultKeymap = "vicmd";

    dotDir = ".zsh.d";

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

    plugins = [
      {
        name = "zsh-aws-vault";
        src = pkgs.fetchFromGitHub {
          owner = "blimmer";
          repo = "zsh-aws-vault";
          rev = "main";
          sha256 = "sha256-0moXhhSHShnISBxG2xhrmn29MJ0zos+jcjnAMOdOU1Y=";
        };
      }
      {
        name = "tipz";
        src = pkgs.fetchFromGitHub {
          owner = "molovo";
          repo = "tipz";
          rev = "master";
          sha256 = "sha256-pLdF8wbkA9mPI5cg8VPYAW7i3cWNJX3+lfAZ5cZPUgE=";
        };
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "rupa";
          repo = "z";
          rev = "master";
          sha256 = "sha256-pLdF8wbkA9mPI5cg8VPYAW7i3cWNJX3+lfAZ5cZPUgE=";
        };
      }
      {
        name = "cd-gitroot";
        src = pkgs.fetchFromGitHub {
          owner = "mollifier";
          repo = "cd-gitroot";
          rev = "master";
          sha256 = "sha256-pLdF8wbkA9mPI5cg8VPYAW7i3cWNJX3+lfAZ5cZPUgE=";
        };
      }
    ];
  };

}
