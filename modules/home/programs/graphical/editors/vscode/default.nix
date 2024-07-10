{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.graphical.editors.vscode;
in {
  options.${namespace}.programs.graphical.editors.vscode = {
    enable = mkBoolOpt false "Enable vscode";
    declarativeConfig = mkBoolOpt false "Enable declarative configuration";
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;

      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
        catppuccin.catppuccin-vsc
        christian-kohler.path-intellisense
        davidanson.vscode-markdownlint
        denoland.vscode-deno
        eamodio.gitlens
        editorconfig.editorconfig
        esbenp.prettier-vscode
        github.vscode-github-actions
        github.vscode-pull-request-github
        golang.go
        gruntfuggly.todo-tree
        kamadorueda.alejandra
        ms-kubernetes-tools.vscode-kubernetes-tools
        ms-python.python
        ms-vscode-remote.remote-ssh
        redhat.vscode-yaml
        shardulm94.trailing-spaces
        sumneko.lua
        tim-koehler.helm-intellisense
        timonwong.shellcheck
        usernamehw.errorlens
        vscode-icons-team.vscode-icons
        yzhang.markdown-all-in-one
      ];

      userSettings = mkIf cfg.declarativeConfig {
        # Color theme
        "workbench.colorTheme" = "Catppuccin Mocha";
        "catppuccin.accentColor" = "blue";

        # Font
        "editor.fontFamily" = "JetBrainsMono Nerd Font, monospace";
        "editor.codeLensFontFamily" = "JetBrainsMono Nerd Font, monospace";
        "editor.inlayHints.fontFamily" = "JetBrainsMono Nerd Font, monospace";
        "debug.console.fontFamily" = "JetBrainsMono Nerd Font, monospace";
        "scm.inputFontFamily" = "JetBrainsMono Nerd Font, monospace";
        "terminal.integrated.fontFamily" = "JetBrainsMono Nerd Font, monospace";

        # Git settings
        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableSmartCommit" = true;
        "git.openRepositoryInParentFolders" = "always";
        "gitlens.gitCommands.skipConfirmations" = [
          "fetch:command"
          "stash-push:command"
          "switch:command"
          "branch-create:command"
        ];

        # Editor
        "editor.lineHeight" = 1;
        "markdown.preview.lineHeight" = 1.2;
        "editor.bracketPairColorization.enabled" = true;
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
        "editor.guides.bracketPairs" = true;
        "editor.guides.indentation" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.overviewRulerBorder" = false;
        "editor.renderLineHighlight" = "all";
        "editor.smoothScrolling" = true;
        "editor.suggestSelection" = "first";

        # Terminal
        "terminal.integrated.automationShell.linux" = "nix-shell";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.gpuAcceleration" = "on";

        # Workbench
        "workbench.fontAliasing" = "antialiased";
        "workbench.list.smoothScrolling" = true;
        "workbench.panel.defaultLocation" = "right";
        "workbench.startupEditor" = "none";

        # Miscellaneous
        "breadcrumbs.enabled" = true;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmDelete" = false;
        "explorer.compactFolders" = false;
        "extensions.ignoreRecommendations" = true;
        "files.trimTrailingWhitespace" = true;
        "security.workspace.trust.enabled" = false;
        "todo-tree.filtering.includeHiddenFiles" = true;
        "window.menuBarVisibility" = "toggle";
        "window.nativeTabs" = true;
        "window.restoreWindows" = "all";
        "window.titleBarStyle" = "custom";
      };
    };
  };
}
