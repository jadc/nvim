---@type vim.lsp.Config
return {
    settings = {
        ["rust-analyzer"] = {
            check = {
                command = "clippy",
            },
            inlayHints = {
                lifetimeElisionHints = {
                    enable = "skip_trivial",
                    useParameterNames = true,
                },
            },
        },
    },
}
