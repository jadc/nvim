local mappings = {
    -- Allow movement through wrapped lines, but only when no count is given
    {
        key = "j",
        action = function() return vim.v.count > 0 and "j" or "gj" end,
        mode = { "n", "x" },
        options = { expr = true },
    },
    {
        key = "k",
        action = function() return vim.v.count > 0 and "k" or "gk" end,
        mode = { "n", "x" },
        options = { expr = true },
    },
    {
        key = "$",
        action = "g$",
        mode = { "n", "x" },
    },
    {
        key = "0",
        action = "g0",
        mode = { "n", "x" },
    },

    -- Maintain selection after indent
    {
        key = "<",
        action = "<gv",
        mode = { "v" },
    },
    {
        key = ">",
        action = ">gv",
        mode = { "v" },
    },

    -- Center search query to middle of buffer
    {
        key = "n",
        action = "nzzzv",
        mode = { "n" },
    },
    {
        key = "N",
        action = "Nzzzv",
        mode = { "n" },
    },

    -- Jumplist navigation
    {
        key = ",",
        action = "<C-o>",
        mode = { "n" },
        options = { desc = "Jump back" },
    },
    {
        key = ".",
        action = "<C-i>",
        mode = { "n" },
        options = { desc = "Jump forward" },
    },

    -- Close current buffer, switch to previous
    {
        key = "<C-x>",
        action = function()
            local buf = vim.api.nvim_get_current_buf()
            local listed = vim.fn.getbufinfo({ buflisted = 1 })

            -- most recent buffer first
            table.sort(listed, function(a, b) return a.lastused > b.lastused end)

            local other = vim.iter(listed):find(function(b) return b.bufnr ~= buf end)
            if other then
                -- switch away before deleting to keep the window/split open
                vim.cmd("buffer " .. other.bufnr)
            else
                -- no other buffer left, fall back to an empty one
                vim.cmd("enew")
            end

            vim.cmd("bdelete " .. buf)
        end,
        mode = { "n" },
        options = { desc = "Close buffer" },
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
    vim.keymap.set({ "n", "x", "i" }, key, "<Nop>")
end
