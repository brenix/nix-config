{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.matrix; let
  cfg = config.cli.multiplexers.tmux;
in {
  options.cli.multiplexers.tmux = with types; {
    enable = mkBoolOpt false "enable tmux multiplexer";
  };

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.fish}/bin/fish";
      terminal = "tmux-256color";
      historyLimit = 100000;
      escapeTime = 0;
      keyMode = "vi";
      prefix = "C-x";
      sensibleOnTop = true;
      mouse = true;
      baseIndex = 1;

      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        yank
        tmux-thumbs
        # must be before continuum edits right status bar
        {
          plugin = catppuccin;
          extraConfig = ''
            set -g @catppuccin_flavour 'mocha'
            set -g @catppuccin_window_left_separator "█"
            set -g @catppuccin_window_right_separator "█"
            set -g @catppuccin_window_middle_separator "█ "
            set -g @catppuccin_window_number_position "left"

            set -g @catppuccin_window_default_fill "number"
            set -g @catppuccin_window_default_text "#W"

            set -g @catppuccin_window_current_fill "number"
            set -g @catppuccin_window_current_text "#W"

            set -g @catppuccin_status_modules "application session date_time"
            set -g @catppuccin_status_left_separator  ""
            set -g @catppuccin_status_right_separator ""
            set -g @catppuccin_status_right_separator_inverse "no"
            set -g @catppuccin_status_fill "icon"
            #set -g @catppuccin_status_connect_separator "no"

            set -g @catppuccin_directory_text "#{pane_current_path}"
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '10'
            set -g @continuum-systemd-start-cmd 'start-server'
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"
        set -g default-terminal "tmux-256color"
        set -ga terminal-overrides ",xterm*:Tc"
        set -ga terminal-overrides ",rxvt*:Tc"
        set -ga terminal-overrides ",screen*:Tc"
        set -ga terminal-overrides ",tmux*:Tc"
        set -ga terminal-overrides ",alacritty*:Tc"
        set -ga terminal-overrides ",st*:Tc"
        set -ga terminal-overrides ",foot*:Tc"
        set-environment -g TMUX_PLUGIN_MANAGER_PATH '~/.local/share/tmux/plugins'
        set-option -g set-titles on
        set-option -g set-titles-string "#S / #W"

        # Change splits to match helix and easier to remember
        # Open new split at cwd of current split
        unbind %
        unbind '"'
        bind v split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"

        # Layout
        bind , select-layout even-vertical
        bind . select-layout even-horizontal

        # Windows
        bind n new-window -c "#{pane_current_path}"
        bind tab next-window
        bind t command-prompt "rename-window %%"
        bind-key -n M-q prev
        bind-key -n M-e next

        # Panes
        bind v setw synchronize-panes\; display "Sync panes is now #{?pane_synchronized,on,off}!"
        bind h select-pane -L
        bind l select-pane -R
        bind k select-pane -U
        bind j select-pane -D
        bind up resize-pane -U 5
        bind down resize-pane -D 5
        bind left resize-pane -L 5
        bind right resize-pane -R 5

        # Use vim keybindings in copy mode
        set-window-option -g mode-keys vi

        # v in copy mode starts making selection
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        # Escape turns on copy mode
        bind Escape copy-mode

        # Easier reload of config
        bind r source-file ~/.config/tmux/tmux.conf

        #set-option -g status-position top

        # make Prefix p paste the buffer.
        unbind p
        bind p paste-buffer

        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        bind-key -T copy-mode-vi M-h resize-pane -L 1
        bind-key -T copy-mode-vi M-j resize-pane -D 1
        bind-key -T copy-mode-vi M-k resize-pane -U 1
        bind-key -T copy-mode-vi M-l resize-pane -R 1
      '';
    };
  };
}
