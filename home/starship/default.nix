_: {

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$aws$python$jobs$status$character
      '';
      right_format = ''
        $kubernetes
      '';
      aws = {
        format = "[$profile \\($region\\)]($style) ";
      };
      character = {
        success_symbol = "[▶](bold green)";
        error_symbol = "[▶](bold red)";
      };
      directory = {
        style = "blue";
      };
      git_branch = {
        format = "[$branch](cyan) ";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname]($style) ";
      };
      kubernetes = {
        disabled = false;
        format = "[$context](yellow)[:](bright-black)[$namespace](white)";
        context_aliases = {
          ".*vdp.*" = "vdp";
          "(?P<var_cell>[\\\\w-]+)-aws-\\\\w+-(?P<var_cluster>[\\\\w-]+)-.*" = "$var_cell-$var_cluster";
        };
      };
      python = {
        format = "[(($virtualenv))]($style) ";
      };
    };
  };

}
