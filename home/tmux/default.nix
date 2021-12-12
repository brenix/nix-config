{ ... }: {

  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "tmux-256color";
    escapeTime = 0;
    keyMode = "vi";
    baseIndex = 1;
    extraConfig = ''
      # -- options

      # screen mode
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm*:Tc"
      set -ga terminal-overrides ",rxvt*:Tc"
      set -ga terminal-overrides ",screen*:Tc"
      set -ga terminal-overrides ",tmux*:Tc"
      set -ga terminal-overrides ",alacritty*:Tc"
      set -ga terminal-overrides ",st*:Tc"

      # mouse
      set-option -g mouse on

      # use xterm keycodes
      setw -g xterm-keys on

      # -- keybindings

      # windows
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind n new-window -c "#{pane_current_path}"
      bind tab next-window
      bind t command-prompt "rename-window %%"

      # window switching
      bind-key -n M-q prev
      bind-key -n M-e next

      # layout
      bind , select-layout even-vertical
      bind . select-layout even-horizontal

      # synchronize panes
      bind v setw synchronize-panes\; display "Sync panes is now #{?pane_synchronized,on,off}!"

      # reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"

      # vim style copy paste mode
      unbind [
      bind Escape copy-mode
      unbind p
      bind p paste-buffer
      bind-key -Tcopy-mode-vi 'v' send -X begin-selection

      # panes
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D
      bind up resize-pane -U 5
      bind down resize-pane -D 5
      bind left resize-pane -L 5
      bind right resize-pane -R 5

      # -- THEME

      # panes
      set -g pane-border-style "fg=colour8"
      set -g pane-active-border-style "fg=colour8"

      # status bar
      set -g status-bg '#191c26'
      set -g status-fg black
      set -g status-justify "left"
      set -g status "on"
      set -g status-interval 2

      # windows
      set -g set-titles off
      setw -g window-status-current-format "#[fg=#161821,bg=#68809A] #I #[fg=white,bg=default] #W"
      setw -g window-status-format "#[fg=black,bg=brightblack] #I #[fg=brightblack,bg=default] #W"

      # left side
      set -g status-left ""

      # right side
      set -g status-right-length 120
      set -g status-right ""
      set -g status-right "#(/usr/bin/env bash $HOME/.config/tmux/kube.tmux black white)"
    '';
  };

  xdg.configFile = {
    "tmux/kube.tmux".source = ./kube.tmux;
  };
}

