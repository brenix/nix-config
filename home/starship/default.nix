_: {

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
        format = "[$profile \\($region\\)]($style) ";
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
      localip = {
        disabled = true;
      };
      terraform = {
        disabled = false;
        format = "";
      };
      git_branch = {
        format = "[\\(](white)[$branch](cyan)[\\)](white) ";
        symbol = " ";
      };
      git_status = {
        disabled = false;
        conflicted = "";
        ahead = "";
        behind = "";
        diverged = "";
        up_to_date = "";
        untracked = "";
        stashed = "";
        modified = "";
        staged = "";
        renamed = "";
        deleted = "";
      };
      python = {
        disabled = false;
        format = "[(($virtualenv))]($style) ";
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
