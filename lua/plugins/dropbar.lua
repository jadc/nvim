vim.pack.add({ "https://github.com/Bekaboo/dropbar.nvim" })

local file = require("utils.file")

require("dropbar").setup({
    bar = {
        enable = function(buf, win, _)
            buf = vim._resolve_bufnr(buf)
            if
                not vim.api.nvim_buf_is_valid(buf)
                or not vim.api.nvim_win_is_valid(win)
            then
                return false
            end

            if
                not vim.api.nvim_buf_is_valid(buf)
                or not vim.api.nvim_win_is_valid(win)
                or vim.fn.win_gettype(win) ~= ""
                or vim.wo[win].winbar ~= ""
                or vim.bo[buf].ft == "help"
            then
                return false
            end

            return vim.bo[buf].buftype == ""
                or vim.bo[buf].ft == "markdown"
                or pcall(vim.treesitter.get_parser, buf)
                or not vim.tbl_isempty(vim.lsp.get_clients({
                    bufnr = buf,
                    method = "textDocument/documentSymbol",
                }))
        end,
        sources = function(buf, _)
            local sources = require("dropbar.sources")

            -- Keep bar visible for large files, but avoid symbol
            -- providers that can be expensive there.
            if file.is_large(buf) then
                return {
                    sources.path,
                }
            end

            -- Use dropbar's Markdown heading parser.
            if vim.bo[buf].ft == "markdown" then
                return {
                    sources.path,
                    sources.markdown,
                }
            end

            if vim.bo[buf].buftype == "terminal" then
                return {
                    sources.terminal,
                }
            end

            -- Prefer LSP symbols and treesitter context when available.
            local utils = require("dropbar.utils")
            return {
                sources.path,
                utils.source.fallback({
                    sources.lsp,
                    sources.treesitter,
                }),
            }
        end,
    },
})
