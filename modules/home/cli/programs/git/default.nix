{ config
, lib
, ...
}:
with lib;
with lib.nixicle; let
  cfg = config.cli.programs.git;

  rewriteURL =
    lib.mapAttrs'
      (key: value: {
        name = "url.${key}";
        value = { insteadOf = value; };
      })
      cfg.urlRewrites;
in
{
  options.cli.programs.git = with types; {
    enable = mkBoolOpt false "Whether or not to enable git.";
    name = mkOpt (nullOr str) "" "The name to use with git.";
    email = mkOpt (nullOr str) "" "The email to use with git.";
    urlRewrites = mkOpt (attrsOf str) { } "url we need to rewrite i.e. ssh to http";
    allowedSigners = mkOpt str "" "The public key used for signing commits";
  };

  config = mkIf cfg.enable {
    home.file.".ssh/allowed_signers".text = "* ${cfg.allowedSigners}";

    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      extraConfig = {
        apply = { whitespace = "strip"; };
        branch = { autosetuprebase = "always"; };
        init = {
          defaultBranch = "main";
        };

        gpg.format = "ssh";
        gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
        commit.gpgsign = true;
        user.signingkey = "~/.ssh/id_ed25519.pub";

        core = {
          editor = "hx";
          pager = "delta";
          whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
        };

        color = {
          ui = true;
        };

        interactive = {
          diffFitler = "delta --color-only";
        };

        delta = {
          enable = true;
          navigate = true;
          light = false;
          side-by-side = false;
          options.syntax-theme = "catppuccin";
          options.color-only = true;
        };

        diff."sopsdiffer" = { textconv = "sops -d"; };

        pull = {
          ff = "only";
          rebase = true;
        };

        push = {
          default = "current";
          autoSetupRemote = true;
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
