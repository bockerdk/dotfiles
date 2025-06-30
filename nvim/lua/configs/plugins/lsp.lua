return {
    {
    'neovim/nvim-lspconfig',
    dependencies = {
        'saghen/blink.cmp',
        { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
        -- Auto format on save using the attached LSP
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "",
            command = ":silent lua vim.lsp.buf.format()"
        })

        -- On LSP attach
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(ev)
                vim.lsp.completion.enable(true, ev.data.client_id, ev.buf)
            end,
        })

        -- On LSP detach
        vim.api.nvim_create_autocmd('LspDetach', {
            callback = function(ev)
                vim.lsp.buf.clear_references()
            end,
        })

        local nvim_lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
        local blink_lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
        local all_capabilities = vim.tbl_deep_extend("force", nvim_lsp_capabilities, blink_lsp_capabilities)

        local lspconfig = require('lspconfig')


        lspconfig.rust_analyzer.setup({
            capabilities = all_capabilities,
            settings = {
                ["rust-analyzer"] = {
                    check = {
                        command = "clippy",
                    },
                }
            }
        })
    end
},
{ -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-j>'] = { 'select_next' },
        ['<C-k>'] = { 'select_prev' },
      },
      appearance = {
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },
      sources = {
        default = { 'lsp', 'path' },
      },
      fuzzy = { implementation = 'lua' },
      signature = { enabled = true },
    },
  },
}
