{
    outputs = { self, ... }: {
        homeManagerModules.default = { lib, pkgs, ... }: {
            xdg.configFile."nvim".source = self;

            # Configure environment and aliases
            home.sessionVariables.EDITOR = "nvim";
            home.shellAliases = {
                vi = "nvim";
                vim = "nvim";
                vimdiff = "nvim -d";
            };

            # Install all required packages
            home.packages = [
                pkgs.neovim
                pkgs.fd
                pkgs.fzf
                pkgs.gcc
                pkgs.gnumake
                pkgs.ripgrep
                pkgs.tree-sitter
                pkgs.wl-clipboard
                pkgs.xclip

                # Language Servers
                pkgs.bash-language-server
                pkgs.clang-tools
                pkgs.clippy
                pkgs.gopls
                pkgs.lua-language-server
                pkgs.nixd
                pkgs.pyright
                pkgs.rust-analyzer
                pkgs.svelte-language-server
                pkgs.typescript-language-server
                pkgs.vscode-langservers-extracted
                pkgs.yaml-language-server

                # Formatters
                (lib.lowPrio pkgs.gotools)
                pkgs.nixfmt
                pkgs.prettier
                pkgs.ruff
                pkgs.rustfmt
                pkgs.shfmt
                pkgs.taplo
                pkgs.stylua
            ];
        };
    };
}
