return {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiffsplit", "Gvdiffsplit", "Gblame" },
    init = function()
        -- Force Fugitive's native layout engine to spawn the main status
        -- summary pane as a clean horizontal split window at the bottom.
        vim.g.fugitive_layout = { window = "botright 15split" }
    end,
    keys = {
        -- 1. Rock-Solid Git Status Toggle
        {
            "<leader>gs",
            function()
                if vim.bo.filetype == "fugitive" then
                    vim.cmd("close")
                    return
                end

                -- Match against strict path syntax to capture shifted focus states safely
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if buf_name:match("%.git//") or vim.bo[buf].filetype == "fugitive" then
                        vim.api.nvim_win_close(win, true)
                        return
                    end
                end

                vim.cmd("Git")
            end,
            desc = "Toggle Git Status"
        },

        -- 2. Toggle Git Blame Sidebar
        {
            "<leader>gb",
            function()
                if vim.bo.filetype == "fugitiveblame" then
                    vim.cmd("close")
                    return
                end
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if vim.bo[buf].filetype == "fugitiveblame" then
                        vim.api.nvim_win_close(win, true)
                        return
                    end
                end
                vim.cmd("Git blame")
            end,
            desc = "Toggle Git Blame"
        },

        -- 3. Targeted Git Diff Split Toggle (Protects your code window)
        {
            "<leader>gd",
            function()
                -- If we aren't diffing, open up the side-by-side view normally
                if not vim.wo.diff then
                    vim.cmd("Gvdiffsplit!")
                    return
                end

                -- If we ARE diffing, find and kill only the read-only Fugitive index mirror
                local current_tab = vim.api.nvim_get_current_tabpage()
                local windows = vim.api.nvim_tabpage_list_wins(current_tab)

                for _, win in ipairs(windows) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local buf_name = vim.api.nvim_buf_get_name(buf)

                    if buf_name:match("%.git//") or buf_name:match("fugitive://") then
                        vim.cmd("diffoff!")
                        vim.api.nvim_win_close(win, true)
                        vim.api.nvim_buf_delete(buf, { force = true })
                        return
                    end
                end

                -- Fallback case if it's a generic vimdiff layout
                vim.cmd("diffoff!")
                if #vim.api.nvim_list_wins() > 1 then
                    vim.cmd("close")
                end
            end,
            desc = "Toggle Git Diff Split"
        },
        {
            "<leader>ga",
            "<cmd>Gwrite<cr>",
            desc = "Git Add (Stage Current File)"
        },
        {
            "<leader>gc",
            function()
                vim.ui.input({ prompt = "Commit Message: " }, function(input)
                    if not input or input == "" then
                        print("Commit aborted: No message provided.")
                        return
                    end
                    -- Escape quotes safely in shell execution
                    local escaped_msg = input:gsub('"', '\\"')
                    vim.cmd('Git commit -m "' .. escaped_msg .. '"')
                end)
            end,
            desc = "Git Commit"
        },
        {
            "<leader>gp",
            "<cmd>botright 10split | Git push<cr>",
            desc = "Git Push"
        },
        {
            "<leader>gP",
            "<cmd>botright 10split | Git pull<cr>",
            desc = "Git Pull"
        },

    },
}
