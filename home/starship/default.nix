_: {

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      format = ''
        $username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$aws$python$kubernetes$fill
        $jobs$status$character
      '';
      aws = {
        format = "[$profile \\($region\\) ]($style)";
        style = "bg:#191c26 fg:bold yellow";
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
        style = "bg:#191c26 fg:blue";
      };
      git_branch = {
        format = "[\\($branch\\) ]($style)";
        style = "bg:#191c26 fg:cyan";
      };
      git_status = {
        format = "([\\[$all_status$ahead_behind\\] ]($style))";
        style = "bg:#191c26 fg:bold red";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname ]($style)";
        style = "bg:#191c26 fg:bright-black";
      };
      kubernetes = {
        disabled = true;
        format = "[\\[](bg:#191c26 fg:white)[$context](bg:#191c26 fg:yellow)[:](bg:#191c26 fg:bright-black)[$namespace](bg:#191c26 fg:white)[\\]](bg:#191c26 fg:white)";
        context_aliases = {
          ".*vdp.*" = "vdp";
          "(?P<var_cell>[\\\\w-]+)-aws-\\\\w+-(?P<var_cluster>[\\\\w-]+)-.*" = "$var_cell-$var_cluster";
        };
      };
      python = {
        format = "[(($virtualenv)) ]($style)";
        style = "bg:#191c26 fg:purple bold";
      };
      username = {
        disabled = true;
        show_always = false;
        format = "[$user]($style)";
        style_user = "bg:#191c26 fg:bright-black";
        style_root = "bg:#191c26 fg:bold red";
      };
    };
  };

}
