return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "artemave/workspace-diagnostics.nvim", -- Required for closed-file diagnostics
        {
            "folke/lazydev.nvim",
            ft = "lua",
            dependencies = {
                { 'DrKJeff16/wezterm-types', lazy = true },
            },
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    { path = 'wezterm-types', mods = { 'wezterm' } },
                },
            },
        },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local lspconfig = require("lspconfig")

        -- 1. LSP Attach Logic (Keymaps & Workspace Scan)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local bufnr = event.buf

                if not client then return end

                -- Automate workspace-wide diagnostic scanning
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end

                local copy_diagnostic = function()
                    local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
                    if vim.tbl_isempty(line_diagnostics) then return end

                    -- Get the first diagnostic message on the current line
                    local msg = line_diagnostics[1].message
                    vim.fn.setreg('+', msg) -- Copy to system clipboard
                    print("Copied diagnostic: " .. msg)
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
                map("<leader>ce", copy_diagnostic, "Copy Error message")

                -- Diagnostic navigation
                map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
                map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
            end,
        })

        -- 2. Mason & Server Setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "clangd", "texlab" },
            handlers = {
                -- Default handler
                function(server_name)
                    lspconfig[server_name].setup({
                        capabilities = capabilities,
                    })
                end,
                -- Dedicated Lua handler
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                diagnostics = { globals = { "vim" } },
                            },
                        },
                    })
                end,
            },
        })

        -- 3. Diagnostic Configuration
        vim.diagnostic.config({
            virtual_text = false, -- Turned off so it doesn't clutter your code
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = '✘',
                    [vim.diagnostic.severity.WARN]  = '▲',
                    [vim.diagnostic.severity.HINT]  = '⚑',
                    [vim.diagnostic.severity.INFO]  = '»',
                },
            },
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = true,
                header = "",
                prefix = "",
            },
            underline = true,
            update_in_insert = false,
            severity_sort = true,
        })

        -- Auto-show diagnostic popup on cursor hold
        vim.api.nvim_create_autocmd("CursorHold", {
            callback = function()
                vim.diagnostic.open_float(nil, { focusable = false })
            end,
        })
    end,
}
