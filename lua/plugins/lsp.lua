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
                    { path = 'wezterm-types',      mods = { 'wezterm' } },
                },
            },
        },
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config('*', { capabilities = capabilities })

        vim.lsp.config('lua_ls', {
            settings = {
                Lua = {
                    diagnostics = { globals = { "vim" } },
                },
            },
        })

        vim.lsp.enable({ "lua_ls", "pyright", "clangd", "texlab" })

        -- 1. LSP Attach Logic (Keymaps & Workspace Scan)
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local bufnr = event.buf

                if not client then return end

                if client:supports_method("textDocument/formatting") then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr, async = false })
                        end,
                    })
                end

                -- Automate workspace-wide diagnostic scanning
                require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                end

                local copy_diagnostic = function()
                    local line_diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
                    if vim.tbl_isempty(line_diagnostics) then return end
                    local msg = line_diagnostics[1].message
                    vim.fn.setreg('+', msg)
                    vim.notify("Copied: " .. msg, vim.log.levels.INFO)
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
                map("]d", function() vim.diagnostic.jump({ count = 1 }) end, "Next Diagnostic")
                map("[d", function() vim.diagnostic.jump({ count = -1 }) end, "Prev Diagnostic")
            end,
        })

        -- 2. Mason & Server Setup
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "clangd", "texlab" },
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
                if vim.fn.mode() == "n" then
                    vim.diagnostic.open_float(nil, { focusable = false })
                end
            end,
        })
    end,
}
