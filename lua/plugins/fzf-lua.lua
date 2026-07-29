vim.pack.add({
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/nvim-tree/nvim-web-devicons",
})

vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = "#404040" })

require("fzf-lua").setup({
    winopts = {
        height = 0.95,
        width = 0.95,
        row = 0.5,
        col = 0.5,
        border = "single",
        hls = {
            border = "FzfLuaBorder",
        },
        preview = {
            layout = "flex",
            flip_columns = 120,
            horizontal = "right:50%",
            vertical = "down:50%",
        },
    },
    fzf_opts = {
        ["--layout"] = "reverse",
    },
    keymap = {
        fzf = {
            ["tab"] = "down",
            ["shift-tab"] = "up",
        },
    },
})

-- Keybindings
local fzf = require("fzf-lua")

vim.keymap.set({ "n", "x" }, "<c-f>", fzf.live_grep, { noremap = true, silent = true })
vim.keymap.set({ "n", "x" }, "<c-p>", fzf.files, { noremap = true, silent = true })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { noremap = true, silent = true, desc = "Buffers" })

-- LSP keybindings
vim.keymap.set("n", "grd", fzf.lsp_definitions)
vim.keymap.set("n", "gra", fzf.lsp_code_actions)
vim.keymap.set("n", "gri", fzf.lsp_implementations)
vim.keymap.set("n", "grr", fzf.lsp_references)
vim.keymap.set("n", "grt", fzf.lsp_typedefs)
vim.keymap.set("n", "grD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gre", vim.diagnostic.open_float)
vim.keymap.set("n", "grE", vim.diagnostic.setqflist)
