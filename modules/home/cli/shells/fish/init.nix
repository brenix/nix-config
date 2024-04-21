{
  programs.fish.interactiveShellInit =
    # Use zoxide
    ''
      if command -sq zoxide
        zoxide init fish | source
        alias cd 'z'
      end
    ''
    +
    # Paths
    ''
      set -gx PATH $PATH $HOME/.local/bin $HOME/.krew/bin $GOPATH/bin
    ''
    +
    # Completions
    ''
      complete -c ssh-multi -w ssh
    ''
    +
    # Set kubeconfig var
    ''
      if command -sq kubectl
        for line in (find $HOME/.kube -maxdepth 1 \( -type f -o -type l \) -print)
          set -x KUBECONFIG "$KUBECONFIG:$line"
        end
      end
    ''
    +
    # Bindings
    ''
      bind \ce end-of-line
      bind ! bind_bang
      bind '$' bind_dollar
    ''
    +
    # Use terminal colors
    ''
      set -U fish_color_autosuggestion      brblack
      set -U fish_color_cancel              -r
      set -U fish_color_command             brgreen
      set -U fish_color_comment             brmagenta
      set -U fish_color_cwd                 green
      set -U fish_color_cwd_root            red
      set -U fish_color_end                 brmagenta
      set -U fish_color_error               brred
      set -U fish_color_escape              brcyan
      set -U fish_color_history_current     --bold
      set -U fish_color_host                normal
      set -U fish_color_match               --background=brblue
      set -U fish_color_normal              normal
      set -U fish_color_operator            cyan
      set -U fish_color_param               brblue
      set -U fish_color_quote               yellow
      set -U fish_color_redirection         bryellow
      set -U fish_color_search_match        'bryellow' '--background=brblack'
      set -U fish_color_selection           'white' '--bold' '--background=brblack'
      set -U fish_color_status              red
      set -U fish_color_user                brgreen
      set -U fish_color_valid_path          --underline
      set -U fish_pager_color_completion    normal
      set -U fish_pager_color_description   yellow
      set -U fish_pager_color_prefix        'white' '--bold' '--underline'
      set -U fish_pager_color_progress      'brwhite' '--background=cyan'
    ''
    +
    # Source private files
    ''
      for file in ~/.config/fish/conf.local.d/*.fish
        source $file
      end
    '';
}
