-- Sensible default LSP configs
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

-- Setup styling of error virtual text
vim.diagnostic.config({
    virtual_text = false,      -- Disable in-line errors
    virtual_lines = true,      -- Enable errors on separate line
    underline = true,
    signs = true,
    update_in_insert = false,  -- Only update errors in normal mode
    severity_sort = true,      -- Show errors over warnings
})

-- Enable inlay hints
vim.lsp.inlay_hint.enable(true)

-- Disable logging to ~/.local/state/nvim/lsp.log
vim.lsp.log.set_level("off")

-- Enable language servers
vim.lsp.enable({
    "bashls",
    "clangd",
    "cssls",
    "eslint",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "nixd",
    "pyright",
    "rust_analyzer",
    "svelte",
    "ts_ls",
    "yamlls",
})

-- Keybindings
local ok, fzf = pcall(require, "fzf-lua")

-- Unbind Neovim's default gr* LSP mappings (global, set at startup)
for _, lhs in ipairs({ "grn", "gra", "gri", "grr", "grt", "grx" }) do
    pcall(vim.keymap.del, "n", lhs)
end

vim.keymap.set("n", "gd", ok and fzf.lsp_definitions or vim.lsp.buf.definition)
vim.keymap.set("n", "gi", ok and fzf.lsp_implementations or vim.lsp.buf.implementation)
vim.keymap.set("n", "gr", ok and fzf.lsp_references or vim.lsp.buf.references)
vim.keymap.set("n", "gt", ok and fzf.lsp_typedefs or vim.lsp.buf.type_definition)

vim.keymap.set("n", "ga", vim.lsp.buf.code_action)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "gE", vim.diagnostic.setqflist)
