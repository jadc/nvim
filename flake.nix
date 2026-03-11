{
    outputs = { ... }: {
        homeManagerModules.default = { lib, pkgs, ... }: {
            programs.neovim = {
                enable = true;
                defaultEditor = true;
                viAlias = true;
                vimAlias = true;
                vimdiffAlias = true;
            };

            # Clone nvim config if it doesn't exist
            home.activation.cloneNvimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                if [ ! -d "$HOME/.config/nvim" ]; then
                    ${pkgs.git}/bin/git clone https://github.com/jadc/nvim "$HOME/.config/nvim"
                fi
            '';

            # Install all required packages
            home.packages = with pkgs; [
                fd
                fzf
                gcc
                gnumake
                ripgrep
                tree-sitter
                wl-clipboard
                xclip

                # Language Servers
                bash-language-server
                clang-tools
                clippy
                gopls
                lua-language-server
                nixd
                pyright
                rust-analyzer
                svelte-language-server
                typescript-language-server
                vscode-langservers-extracted
                yaml-language-server

                # Formatters
                gotools
                nixfmt
                nodePackages.prettier
                ruff
                rustfmt
                shfmt
                taplo
                stylua
            ];
        };
    };
}
