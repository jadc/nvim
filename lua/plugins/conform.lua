vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
    formatters_by_ft = {
        sh = { "shfmt" },
        bash = { "shfmt" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        css = { "prettier" },
        go = { "gofmt", "goimports" },
        html = { "prettier" },
        javascript = { "prettier" },
        json = { "prettier" },
        lua = { "stylua" },
        nix = { "nixfmt" },
        python = { "ruff_format" },
        rust = { "rustfmt" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        markdown = { "prettier" },
        toml = { "taplo" },
        yaml = { "prettier" },
    },
    -- Use formatter built into LSP as fallback
    default_format_opts = {
        lsp_format = "fallback",
    },
})

-- Set gq to format based on context (such as visual blocks)
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Set gq with no context to just format entire buffer
-- This however prevents code motions after gq
vim.keymap.set("n", "gq", function()
    require("conform").format()
end)
