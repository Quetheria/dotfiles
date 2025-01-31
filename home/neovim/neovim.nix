{ config, pkgs, ... }:
{

  packages = with pkgs; [
    

    java-language-sever
    rust-analyzer

    ripgrep
    fd

  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;

    plugins = with pkgs.vimPlugins; [
     

      lazy-nvim

      which-key-nvim


      catppucin-nvim 
      vim-airline

      
      
      nvim-cmp
      cmp-buffer
      cmp-path
      cmpp_luasnip
      cmp-nvim-lsp
      cmp-cmdline

      #snip
      luasnip
      friendly-snippets

      # linting
      nvim-lspconfig
      nvim-lint

      telescope-nvim
      plenary-nvim

      {
        plugin = alpha-nvim;

        config = (builtins.readFile ./plugins/alpha.lua);
      }


    ];

 




    };



}


