{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  packages = with pkgs; [
    alejandra
    asm-lsp
    clang-tools_17
    dockerfile-language-server-nodejs
    java-language-sever
    nil
    nodePackages.bash-language-server
    rust-analyzer
    statix

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

      # decorations
      alpha-nvim
      catppucin-nvim
      mini.icons
      lualine-nvim

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
    ];

    extraLuaConfig = ''

      require("lazy").setup({
        spec = {
          -- import your plugins
          { import = "plugins" },
        },
        dev = {
          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = { "catppucin", "goolord", "hrsh7th", "saadparwaiz1", "L3MON4D3", "rafamadriz",
            "nvim-tree", "neovim", "mfussenegger", "echasnovski", "nvim-lua", "nvim-telescope",
            "sar", "nvim-lualine",

          },
        },
        install = { missing = false, },

      })
      require("options")
      require("bindings")
    '';
    xdg.configFile."nvim/lua" = {
      recursive = true;
      source = "${inputs.self.outPath}/home/assets/nvim/lua";
    };
  };
}
