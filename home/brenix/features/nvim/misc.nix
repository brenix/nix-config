{ pkgs, ... }:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    comment-box-nvim
    editorconfig-nvim
    mkdir-nvim
    nginx-vim
    pgsql-vim
    project-nvim
    quickfix-reflector-vim
    switch-vim
    vim-easy-align
    vim-helm
    vim-markdown
    vim-nix
    vim-surround
    vim-terraform
    vim-toml
    {
      plugin = todo-comments-nvim;
      type = "lua";
      config = /* lua */ ''
        require("todo-comments").setup{}
      '';
    }
    {
      plugin = nvim-autopairs;
      type = "lua";
      config = /* lua */ ''
        require("nvim-autopairs").setup{}
      '';
    }
    {
      plugin = mkdir-nvim;
      type = "lua";
      config = /* lua */ ''
        require("mkdir")
      '';
    }
    {
      plugin = nvim-comment;
      type = "lua";
      config = /* lua */ ''
        require("nvim_comment").setup()
      '';
    }
  ];
}
