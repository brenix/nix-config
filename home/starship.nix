{ pkgs, ... }: {

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[▶](bold green)";
        error_symbol = "[▶](bold red)";
      };
      aws = {
        disabled = false;
        format = "[$profile(\$region\))]($style) ";
      };
      directory = {
        disabled = false;
        style = "blue";
      };
      hostname = {
        disabled = false;
        ssh_only = true;
        format = "[$hostname]($style) ";
      };
      terraform = {
        disabled = false;
        format = "";
      };
      git_branch = {
        disabled = false;
        format = "[\\(](white)[$branch](cyan)[\\)](white) ";
      };
      python = {
        disabled = false;
        format = "[(\($virtualenv\))]($style) ";
      };

      cmd_duration.disabled = true;
      golang.disabled = true;
      helm.disabled = true;
      kubernetes.disabled = true;
      line_break.disabled = true;
      lua.disabled = true;
      username.disabled = true;
    };
  };

}
