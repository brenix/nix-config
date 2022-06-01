_: {

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$aws$python$kubernetes
        $jobs$status$character
      '';
      aws = {
        format = "[$profile \\($region\\) ]($style)";
      };
      fill = {
        symbol = " ";
        style = "bg:#191c26";
      };
      character = {
        success_symbol = "[▶](bold green)";
        error_symbol = "[▶](bold red)";
      };
      directory = {
        format = "[$path ]($style)";
        style = "blue";
      };
      git_branch = {
        format = "[\\[$branch\\] ]($style)";
        style = "cyan";
      };
      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        style = "bold red";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname ]($style)";
        style = "bright-black";
      };
      kubernetes = {
        disabled = false;
        format = "[\\[$context\\]]($style) ";
        style = "fg:#6f717b";
        /* format = "[\\[](bright-black)[$context](yellow)[:](bright-black)[$namespace](white)[\\]](bright-black)"; */
        context_aliases = {
          ".*vdp.*" = "vdp";
          "(?P<var_cell>[\\\\w-]+)-aws-\\\\w+-(?P<var_cluster>[\\\\w-]+)-.*" = "$var_cell-$var_cluster";
        };
      };
      python = {
        format = "[(($virtualenv)) ]($style)";
        style = "fg:purple bold";
      };
      username = {
        disabled = true;
        show_always = false;
        format = "[$user]($style)";
        style_user = "bright-black";
        style_root = "bold red";
      };
    };
  };

}
