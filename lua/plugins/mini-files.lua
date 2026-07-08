vim.pack.add({ "https://github.com/echasnovski/mini.files" })

require("mini.files").setup()

vim.keymap.set("n", "-", function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
    require("mini.files").open(path)
end, { desc = "Open file explorer" })
