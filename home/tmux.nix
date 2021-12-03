{ config, pkgs, ... }: {
  programs.tmux = {
    enable = true;
    prefix = "C-x";
    terminal = "tmux-256color";
    escapeTime = 0;
    baseIndex = 1;
    extraConfig = ''
      set-option -g mouse on
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind n new-window -c "#{pane_current_path}"
      bind tab next-window
      bind t command-prompt "rename-window %%"
      bind , select-layout even-vertical
      bind . select-layout even-horizontal
      bind v setw synchronize-panes\; display "Sync panes is now #{?pane_synchronized,on,off}!"
      bind h select-pane -L
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D
      bind up resize-pane -U 5
      bind down resize-pane -D 5
      bind left resize-pane -L 5
      bind right resize-pane -R 5
    '';
  };
}
