{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.programs.git;
  inherit (config.colorscheme) variant;

  rewriteURL =
    lib.mapAttrs'
    (key: value: {
      name = "url.${key}";
      value = {insteadOf = value;};
    })
    cfg.urlRewrites;
in {
  options.cli.programs.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
    name = mkOpt (nullOr str) "Paul Nicholson" "The name to use with git.";
    email = mkOpt (nullOr str) "brenix@gmail.com" "The email to use with git.";
    urlRewrites = mkOpt (attrsOf str) {} "url we need to rewrite i.e. ssh to http";
    allowedSigners = mkOpt str "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG++dlRrheRZgVLtzadOWFJgHgEL27t70oUZyLwL1o0F" "The public key used for signing commits";
  };

  config = mkIf cfg.enable {
    home.file.".ssh/allowed_signers".text = "* ${cfg.allowedSigners}";

    home.packages = with pkgs; [
      delta
    ];

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig =
        {
          apply = {whitespace = "strip";};
          branch = {autosetuprebase = "always";};
          init = {
            defaultBranch = "main";
          };

          gpg.format = "ssh";
          gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
          commit.gpgsign = true;
          user.signingkey = "~/.ssh/id_ed25519.pub";

          core = {
            editor = "hx";
            whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
          };

          format = {
            pretty = "%C(yellow)%H%Creset %C(magenta)%cd%Creset %d %s %C(green)%an";
          };

          color = {
            ui = true;
          };

          color."branch" = {
            current = "normal reverse";
            local = "normal";
            remote = "green";
          };
          color."diff" = {
            meta = "white bold";
            frag = "magenta bold";
            old = "red bold";
            new = "green bold";
          };
          color."status" = {
            added = "green";
            changed = "magenta";
            untracked = "white";
          };

          interactive = {
            diffFilter = "delta --color-only";
          };

          delta = {
            enable = true;
            light =
              if variant == "light"
              then true
              else false;
            side-by-side = false;
            options = {
              syntax-theme = "catppuccin";
              color-only = true;
              minus-style =
                if variant == "dark"
                then "black #9f7777"
                else "black #ffebe9";
              minus-emph-style =
                if variant == "dark"
                then "black #f7b9b9"
                else "black #ffc0c0";
              plus-style =
                if variant == "dark"
                then "black #98ad9c"
                else "black #e6ffec";
              plus-emph-style =
                if variant == "dark"
                then "black #e1ffe6"
                else "black #abf2bc";
            };
          };

          diff."sopsdiffer" = {textconv = "sops -d";};

          pull = {
            rebase = true;
          };

          push = {
            default = "current";
            autoSetupRemote = true;
          };

          fetch = {
            pruneTags = true;
            prune = true;
          };
        }
        // rewriteURL;
    };

    programs.lazygit = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        git = {
          paging = {
            colorArg = "always";
            pager = "delta --color-only --dark --paging=never";
            useConfig = false;
          };
        };
        customCommands = [
          {
            key = "W";
            command = "git commit -m '{{index .PromptResponses 0}}' --no-verify";
            description = "commit without verification";
            context = "global";
            subprocess = true;
          }
          {
            key = "S";
            command = "git commit -m '{{index .PromptResponses 0}}' --no-gpg-sign";
            description = "commit without gpg signing";
            context = "global";
            subprocess = true;
          }
        ];
      };
    };
  };
}
