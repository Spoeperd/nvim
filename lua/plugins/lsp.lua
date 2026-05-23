return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "artemave/workspace-diagnostics.nvim",
    },
    config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        vim.lsp.config('*', { capabilities = capabilities })
        vim.lsp.enable({ "lua_ls", "pyright", "clangd", "texlab" })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                local bufnr = event.buf

                if not client then return end

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

                map("<leader>rn", vim.lsp.buf.rename, "Rename")
                map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                map("K", vim.lsp.buf.hover, "Hover documentation")
                map("gD", vim.lsp.buf.declaration, "Go to declaration")
                map("<leader>ce", copy_diagnostic, "Copy Error message")
                map("]e", function() vim.diagnostic.jump({ count = 1, float = true, }) end, "Next Diagnostic")
                map("[e", function() vim.diagnostic.jump({ count = -1, float = true, }) end, "Prev Diagnostic")
            end,
        })

        vim.diagnostic.config({
            virtual_text = false,
            underline = true,
            update_in_insert = false,
            severity_sort = true,

            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN]  = " ",
                    [vim.diagnostic.severity.HINT]  = "💡",
                    [vim.diagnostic.severity.INFO]  = " ",
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
        })
    end,
}
