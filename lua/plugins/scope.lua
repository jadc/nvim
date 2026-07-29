vim.pack.add({
    "https://github.com/HiPhish/rainbow-delimiters.nvim",
    "https://github.com/lukas-reineke/indent-blankline.nvim",
})

local rainbow_colors = {
    RainbowRed    = "#E06C75",
    RainbowYellow = "#E5C07B",
    RainbowBlue   = "#61AFEF",
    RainbowOrange = "#D19A66",
    RainbowGreen  = "#98C379",
    RainbowViolet = "#C678DD",
    RainbowCyan   = "#56B6C2",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for name, color in pairs(rainbow_colors) do
        vim.api.nvim_set_hl(0, name, { fg = color })
    end

    -- Match the `Whitespace` group so whitespace-only lines are visible
    local ws = vim.api.nvim_get_hl(0, { name = "Whitespace" })
    vim.api.nvim_set_hl(0, "IblWhitespace", { fg = ws.fg, nocombine = true })
end)

local highlight = vim.tbl_keys(rainbow_colors)

-- rainbow-delimiters config
vim.g.rainbow_delimiters = {
    highlight = highlight
}

-- indent-blankline config
require("ibl").setup({
    indent = {
        -- Do not draw inactive indent guides
        char = " ",
    },
    scope = {
        char = "▏",
        highlight = highlight,
        show_start = false,
        show_end = false,
    },
    whitespace = {
        remove_blankline_trail = true,
    },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
