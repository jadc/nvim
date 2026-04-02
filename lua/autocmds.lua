local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Highlight symbol references under cursor via LSP
local lsp_highlight_group = augroup("LspDocumentHighlight", { clear = true })
autocmd({ "CursorHold", "CursorHoldI" }, {
    group = lsp_highlight_group,
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client:supports_method("textDocument/documentHighlight") then
                vim.lsp.buf.document_highlight()
                return
            end
        end
    end,
})
autocmd("CursorMoved", {
    group = lsp_highlight_group,
    callback = function()
        vim.lsp.buf.clear_references()
    end,
})
