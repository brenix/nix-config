{ config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.programs.starship;
in
{
  options.cli.programs.starship = with types; {
    enable = mkBoolOpt false "Whether or not to enable starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      catppuccin.enable = true;
      settings = {
        add_newline = false;
        format = ''
          $kubernetes$username$hostname$shlvl$directory$git_branch$git_commit$git_state$git_status$aws$python
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
          success_symbol = "[\\$](bold green)";
          error_symbol = "[\\$](bold red)";
        };
        directory = {
          format = "[$path ]($style)";
          style = "blue";
        };
        git_branch = {
          format = "[\\[$branch\\] ]($style)";
          style = "purple";
        };
        git_status = {
          disabled = false;
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
          format = "[\\[$context:$namespace\\]]($style) ";
          style = "bright-black";
          # contexts = [
          #   {
          #     context_pattern = ".*vdp.*";
          #     context_alias = "vdp";
          #   }
          #   {
          #     context_pattern = "(?P<var_cell>[\\w-]+)-aws-\\w+-(?P<var_cluster>[\\w-]+)-.*";
          #     context_alias = "$var_cell-$var_cluster";
          #   }
          # ];
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
  };
}
