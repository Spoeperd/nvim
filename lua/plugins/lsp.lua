return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            dependencies = {
                {
                    'DrKJeff16/wezterm-types',
                    lazy = true,
                    version = false, -- Get the latest version
                },
            },
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    { path = 'wezterm-types', mods = { 'wezterm' } },
                },
            },
        },
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "clangd",
                "texlab",
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("gd", require("telescope.builtin").lsp_definitions, "Go to definition")
                map("gr", require("telescope.builtin").lsp_references, "Go to references")
                map("gI", require("telescope.builtin").lsp_implementations, "Go to implementation")
                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("K", vim.lsp.buf.hover, "Hover documentation")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
            end,
        })

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                },
            },
        })

        vim.lsp.config("pyright", {
            capabilities = capabilities,
        })

        vim.lsp.config("clangd", {
            capabilities = capabilities,
        })

        vim.lsp.config("texlab", {
            capabilities = capabilities,
        })

        -- Enable the LSP servers for their respective filetypes
        vim.lsp.enable("lua_ls")
        vim.lsp.enable("pyright")
        vim.lsp.enable("clangd")
        vim.lsp.enable("texlab")

        -- Configure diagnostics (enables inline virtual text)
        vim.diagnostic.config({
            virtual_text = {
                prefix = '■',
                spacing = 4,
                source = "if_many",
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "if_many",
                header = "",
                prefix = "",
            },
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = true,

        })
    end,

}
