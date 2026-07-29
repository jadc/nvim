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

local function map(lhs, rhs)
    vim.keymap.set("n", "<leader>" .. lhs, rhs)
end

map("f", fzf.live_grep)
map("p", fzf.files)
map("<leader>", fzf.buffers)
