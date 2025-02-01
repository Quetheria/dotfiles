{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  config.programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      alejandra
      asm-lsp
      clang-tools_17
      dockerfile-language-server-nodejs
      java-language-server
      nil
      nodePackages.bash-language-server
      rust-analyzer
      statix

      ripgrep
      fd
    ];
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];

    extraLuaConfig = let
      plugins = with pkgs.vimPlugins; [
        which-key-nvim
        LazyVim
        # decorations
        alpha-nvim
        catppuccin-nvim
        mini-icons
        lualine-nvim

        nvim-cmp
        cmp-buffer
        cmp-path
        cmp_luasnip
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

      mkEntryFromDrv = drv:
        if lib.isDerivation drv
        then {
          name = "${lib.getName drv}";
          path = drv;
        }
        else drv;
      lazyPath = pkgs.linkFarm "lazy-plugins" (builtins.map mkEntryFromDrv plugins);
    in ''
      require("lazy").setup({
        spec = {
          -- import your plugins
          { import = "plugins" },
        },
        dev = {
          path = "${lazyPath}",
          patterns = { "catppuccin", "goolord", "hrsh7th", "saadparwaiz1", "L3MON4D3", "rafamadriz",
            "nvim-tree", "neovim", "mfussenegger", "echasnovski", "nvim-lua", "nvim-telescope",
            "sar", "nvim-lualine",

          },
        },
        install = { missing = false, },

      })
      require("options")
      require("bindings")
    '';
  };

  config.xdg.configFile."nvim/lua" = {
    recursive = true;
    source = "${inputs.self.outPath}/.config/nvim/lua";
  };
}
