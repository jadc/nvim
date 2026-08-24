local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Reload unchanged buffers after returning to Neovim or entering a buffer.
-- Modified buffers are never reloaded, so unsaved edits remain safe.
local checktime_group = augroup("Checktime", { clear = true })
autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
    group = checktime_group,
    callback = function()
        if vim.fn.mode() ~= "c" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight yanked text
local highlight_group = augroup("YankHighlight", { clear = true })
autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 170 })
    end,
    group = highlight_group,
})

-- Close the quickfix list with `q`
local quickfix_group = augroup("Quickfix", { clear = true })
autocmd("FileType", {
    pattern = "qf",
    group = quickfix_group,
    callback = function(args)
        vim.keymap.set("n", "q", "<C-w>c", { buffer = args.buf, desc = "Close quickfix" })
    end,
})

