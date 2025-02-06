{
  config,
  lib,
  namespace,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.starship;
in {
  options.${namespace}.programs.terminal.tools.starship = {
    enable = mkBoolOpt false "Whether or not to enable starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        add_newline = false;
        format = ''
          $username$hostname$kubernetes$directory$git_branch$git_commit$git_state$git_status
          $jobs$status$shlvl$character
        '';
        aws = {
          format = "[$profile \\($region\\) ]($style)";
        };
        fill = {
          symbol = " ";
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
          format = "[\\($branch]($style)";
          # style = "lavender"; # Catppuccin
          style = "magenta";
        };
        git_status = {
          disabled = false;
          # format = "([:](overlay2)[$all_status$ahead_behind](maroon))[\\) ](lavender)"; # Catppuccin
          format = "([:](overlay2)[$all_status$ahead_behind](red))[\\) ](magenta)";
        };
        hostname = {
          disabled = true;
          ssh_only = true;
          format = "[$hostname ]($style)";
          style = "bright-black";
        };
        kubernetes = {
          disabled = false;
          format = "[\\[$context:$namespace\\]]($style) ";
          style = "bold red";
          contexts = [
            {
              context_pattern = ".*(dev|local).*";
              style = "cyan";
            }
          ];
        };
        python = {
          format = "[(($virtualenv)) ]($style)";
          # style = "fg:lavender bold"; # Catppuccin
          style = "fg:magenta bold";
        };
        username = {
          disabled = true;
          show_always = false;
          format = "[$user@]($style)";
          style_user = "bright-black";
          style_root = "bold red";
        };
      };
    };
  };
}
