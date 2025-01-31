return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require('lspconfig')
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities,
        })

        lspconfig.bashls.setup{}

        lspconfig.clangd.setup{}

        lspconfig.dockerls.setup{}
        
        lspconfig.java_language_server.setup{}
        
        lspconfig.julials.setup{}
        
        lspconfig.rust_analyzer.setup {}
        
        lspconfig.nil_ls.setup{
          settings = {
            ['nil'] = {
              formatting = {
                command = { "alejandra" },
              },
            },
          }
        }
    end,
}
