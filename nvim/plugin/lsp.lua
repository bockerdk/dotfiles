-- Enable LSPs
local lsp_configs = {}

for _, f in pairs(vim.api.nvim_get_runtime_file('lsp/*.lua', true)) do
    local server_name = vim.fn.fnamemodify(f, ':t:r')
    table.insert(lsp_configs, server_name)
end

vim.lsp.enable(lsp_configs)

-- Attach
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('bocker.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_clients({ id = args.data.client_id })[1])

        -- Completion
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end

        -- Folding
        -- if client:supports_method('textDocument/foldingRange') then
        --     vim.wo.foldmethod = 'expr'
        --     vim.wo.foldexpr = 'v:vim.lsp.foldexpr()'
        -- end

        -- Format on save
        if client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
                buffer = args.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
                end,
            })
        end

        -- Inlay hints
        -- if client:supports_method('textDocument/inlayHint') then
        --     vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        --     vim.keymap.set("n", "<leader>th", function()
        --         vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }), { bufnr = args.buf })
        --     end, { buffer = args.buf, desc = "Toggle inlay hints" })
        -- end

        -- Code lens
        -- if client:supports_method('textDocument/codeLens') then
        --     vim.lsp.codelens.enable(true, { bufnr = args.buf })
        -- end

        -- Document highlight
        -- if client:supports_method('textDocument/documentHighlight') then
        --     vim.api.nvim_create_autocmd('CursorHold', {
        --         buffer = args.buf,
        --         callback = vim.lsp.buf.document_highlight,
        --     })
        --     vim.api.nvim_create_autocmd('CursorMoved', {
        --         buffer = args.buf,
        --         callback = vim.lsp.buf.clear_references,
        --     })
        -- end
    end,
})
