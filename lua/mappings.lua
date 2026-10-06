local function copy_location(visual)
    local path = vim.fn.expand("%:.")
    if path == "" then
        vim.notify("Current buffer has no file path", vim.log.levels.WARN)
        return
    end

    local first = vim.fn.line(".")
    local location = path .. ":" .. first
    if visual then
        -- Use the active selection, not marks from the previous selection.
        local anchor = vim.fn.line("v")
        first, anchor = math.min(first, anchor), math.max(first, anchor)
        location = path .. ":" .. first .. "-" .. anchor
    end

    vim.fn.setreg('"', location, "v")
    if vim.fn.has("clipboard") == 1 then
        vim.fn.setreg("+", location, "v")
    end
end

local mappings = {
    {
        key = "Y",
        action = function() copy_location(false) end,
        mode = { "n" },
        options = { desc = "Copy relative file path and line" },
    },
    {
        key = "Y",
        action = function()
            copy_location(true)
            vim.cmd.normal({ args = { "\27" }, bang = true })
        end,
        mode = { "x" },
        options = { desc = "Copy relative file path and line range" },
    },

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

            if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted then
                vim.cmd("bdelete " .. buf)
            end
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
