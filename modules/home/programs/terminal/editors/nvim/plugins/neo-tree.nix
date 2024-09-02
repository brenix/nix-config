{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader>E";
        action = ":Neotree action=focus reveal toggle<CR>";
        options = {
          desc = "Explorer toggle";
          silent = true;
        };
      }
    ];

    plugins.neo-tree = {
      enable = true;

      closeIfLastWindow = true;

      filesystem = {
        filteredItems = {
          hideDotfiles = false;
          hideHidden = false;

          neverShowByPattern = [
            ".direnv"
            ".git"
          ];

          visible = true;
        };

        followCurrentFile = {
          enabled = true;
          leaveDirsOpen = true;
        };

        useLibuvFileWatcher.__raw = ''vim.fn.has "win32" ~= 1'';
      };

      window = {
        width = 40;
        autoExpandWidth = false;
      };
    };
  };
}
