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
      sesh
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
        set -g set-clipboard on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        # Splits
        unbind %
        unbind '"'
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"
        bind-key -n M-N split-window -h -c "#{pane_current_path}"
        bind-key -n M-n split-window -v -c "#{pane_current_path}"

        # Layout
        bind , select-layout even-vertical
        bind . select-layout even-horizontal

        # Windows
        set-option -g set-titles on
        set-option -g set-titles-string "#S / #W"
        set-option -g status-interval 2
        set-option -g automatic-rename on
        set-option -g automatic-rename-format '#{b:pane_current_path}'
        set-option -g renumber-windows on

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
        bind-key x kill-pane

        # Copy/Paste
        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
        bind-key -T copy-mode-vi u send -X page-up
        bind-key -T copy-mode-vi d send -X page-down
        bind p paste-buffer
        bind Escape copy-mode
        bind-key -n C-s copy-mode

        # Easier reload of config
        bind r source-file ~/.config/tmux/tmux.conf

        # Sessions
        set-option -g detach-on-destroy off
        bind -N "last-session (via sesh) " L run-shell "sesh last"

        bind T display-popup -E -w 40% "sesh connect \"$(
          sesh list -i -c -t -T -z | fzf --ansi --reverse --filepath-word
        )\""

        bind-key -n M-o display-popup -E -w 40% "sesh connect \"$(
          sesh list -i -c -t -T -z | fzf --ansi --reverse --filepath-word
        )\""

        # Statusbar
        set -g status "on"
        set -g status-bg colour18
        set -g status-fg colour7
        set -g status-justify "left"
        set -g status-left-length "100"
        set -g status-left ""
        set -g status-right-length "100"
        set -g status-right "  #S"
        setw -g window-status-current-format "#[fg=colour0,bg=colour2] #I #[fg=colour7,bg=colour19] #W "
        setw -g window-status-format "#[fg=colour8,bg=colour20] #I #[fg=colour20,bg=colour19] #W "
      '';
    };
  };
}
