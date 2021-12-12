{ ... }: {

  home.file = {
    ".zshrc".source = ./zshrc;
    ".zshenv".source = ./zshenv;
    ".zsh.d".source = ./zsh.d;
    ".zsh.d".recursive = true;
  };

  #programs.zsh = {
  #  enable = true;
  #  enableCompletion = true;

  #  defaultKeymap = "vicmd";

  #  sessionVariables = {
  #    GREP_COLOR = "1;31";
  #    PAGER = "less -inMRF";
  #  };

  #  history = {
  #    save = 10000;
  #    size = 10000;
  #    path = "$HOME/.cache/zsh_history";
  #  };

  #  shellAliases = {
  #    ".." = "cd ..";
  #    cp = "cp -riv";
  #    mv = "mv -iv";
  #    cat = "bat --paging=never --style=plain";
  #    grep = "grep --color=auto";
  #    mkdir = "mkdir -vp";
  #    l = "ls -lhv";
  #    la = "ls -lAvh";
  #    ls = "ls -v --color=always --group-directories-first";
  #    v = "nvim";
  #    s = "sudo systemctl";
  #    q = "googler";
  #    define = "googler -n 2 define";
  #    vm = "virsh start win10";
  #  };
  #};


}
