local mappings = {
    -- Allow movement through wrapped lines, but only when no count is given
    {
        key = "j",
        action = function() return vim.v.count > 0 and "j" or "gj" end,
        mode = { "n", "x" },
        options = { expr = true, silent = true },
    },
    {
        key = "k",
        action = function() return vim.v.count > 0 and "k" or "gk" end,
        mode = { "n", "x" },
        options = { expr = true, silent = true },
    },
    {
        key = "$",
        action = "g$",
        mode = { "n", "x" },
        options = { silent = true },
    },
    {
        key = "0",
        action = "g0",
        mode = { "n", "x" },
        options = { silent = true },
    },

    -- Maintain selection after indent
    {
        key = "<",
        action = "<gv",
        mode = { "v" },
        options = { silent = true },
    },
    {
        key = ">",
        action = ">gv",
        mode = { "v" },
        options = { silent = true },
    },

    -- Center search query to middle of buffer
    {
        key = "n",
        action = "nzzzv",
        mode = { "n" },
        options = { silent = true },
    },
    {
        key = "N",
        action = "Nzzzv",
        mode = { "n" },
        options = { silent = true },
    },

    -- Jumplist navigation
    {
        key = ",",
        action = "<C-o>",
        mode = { "n" },
        options = { silent = true, desc = "Jump back" },
    },
    {
        key = ".",
        action = "<C-i>",
        mode = { "n" },
        options = { silent = true, desc = "Jump forward" },
    },

    -- Buffer navigation
    {
        key = "<Tab>",
        action = "<cmd>bnext<CR>",
        mode = { "n" },
        options = { silent = true, desc = "Next buffer" },
    },
    {
        key = "<S-Tab>",
        action = "<cmd>bprevious<CR>",
        mode = { "n" },
        options = { silent = true, desc = "Previous buffer" },
    },
    -- Buffer management
    {
        key = "<c-w>",
        action = "<cmd>bdelete<CR>",
        mode = { "n" },
        options = { silent = true, nowait = true, desc = "Close buffer" },
    },
    {
        key = "<c-x>",
        action = "<cmd>silent! %bdelete|edit#|silent! bdelete#<CR>",
        mode = { "n" },
        options = { silent = true, nowait = true, desc = "Close other buffers" },
    },
}

for _, map in ipairs(mappings) do
    vim.keymap.set(map.mode, map.key, map.action, map.options)
end

local disabled = {
    -- Disable arrow keys
    "<Up>",
    "<Down>",
    "<Left>",
    "<Right>"
}
for _, key in ipairs(disabled) do
    vim.keymap.set({ "n", "x", "i" }, key, "<Nop>", { silent = true })
end
