{
  config,
  lib,
  namespace,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.terminal.tools.tmux;
in {
  options.${namespace}.programs.terminal.tools.tmux = {
    enable = mkBoolOpt false "enable tmux multiplexer";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      tmux-sessionizer
    ];

    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "xterm-256color";
      historyLimit = 10000;
      escapeTime = 0;
      keyMode = "vi";
      prefix = "C-x";
      sensibleOnTop = true;
      mouse = false;
      baseIndex = 1;
      clock24 = false;

      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        nord
        sensible
        tmux-thumbs
        yank
      ];
      extraConfig = ''
        # Term
        set-option -sa terminal-features ",*xterm*:RGB"
        set -ga terminal-overrides ",xterm*:Tc"
        set -ga terminal-overrides ",rxvt*:Tc"
        set -ga terminal-overrides ",alacritty*:Tc"
        set -ga terminal-overrides ",st*:Tc"
        set -ga terminal-overrides ",foot*:Tc"
        setenv -g COLORTERM "truecolor"
        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        # Splits
        unbind %
        unbind '"'
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind-key -n M-n split-window -h -c "#{pane_current_path}"
        bind-key -n M-N split-window -v -c "#{pane_current_path}"

        # Layout
        bind , select-layout even-vertical
        bind . select-layout even-horizontal

        # Windows
        set-option -g set-titles on
        set-option -g set-titles-string "#S / #W"
        set-option -g status-interval 1
        set-option -g automatic-rename on
        set-option -g automatic-rename-format '#{b:pane_current_path}'

        bind n new-window -c "#{pane_current_path}"
        bind-key -n M-Enter new-window
        bind t command-prompt "rename-window %%"
        bind-key -n M-q prev
        bind-key -n M-e next

        # Panes
        bind v setw synchronize-panes\; display "Sync panes is now #{?pane_synchronized,on,off}!"
        bind-key -n M-h select-pane -L
        bind-key -n M-j select-pane -D
        bind-key -n M-k select-pane -U
        bind-key -n M-l select-pane -R
        bind-key -n M-H resize-pane -L 5
        bind-key -n M-J resize-pane -D 5
        bind-key -n M-K resize-pane -U 5
        bind-key -n M-L resize-pane -R 5

        # Copy/Paste
        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        bind p paste-buffer
        bind Escape copy-mode

        # Easier reload of config
        bind r source-file ~/.config/tmux/tmux.conf
      '';
    };
  };
}
