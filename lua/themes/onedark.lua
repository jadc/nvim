vim.pack.add({ "https://github.com/navarasu/onedark.nvim" })

local _onedark = require("onedark")
_onedark.setup({
    style = "deep",
    transparent = true,
    colors = {
        bg0 = "#000000",
        bg1 = "#000000",
        fg  = "#dde0e5",
    },
    code_style = {
        keywords = "italic",
        comments = "italic",
    },
})
_onedark.load()

-- Keep floating windows transparent so popups use the editor background.
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

-- Requires visual-whitespace-nvim
vim.api.nvim_set_hl(0, "VisualNonText", { fg = "#5d5f71", bg = "#2a324a"})
