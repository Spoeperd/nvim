return {
    "tpope/vim-fugitive",
    keys = {
        {
            "<leader>gs",
            function()
                if vim.bo.filetype == "fugitive" then
                    vim.cmd("close")
                    return
                end

                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local ft = vim.bo[buf].filetype
                    local name = vim.api.nvim_buf_get_name(buf)

                    if ft == "fugitive" or name:match("fugitive://") or name:match("%.git/") then
                        vim.api.nvim_win_close(win, true)
                        return
                    end
                end

                vim.cmd("Git | wincmd H | vertical resize 40")
            end,
            desc = "Toggle Git Status"
        },

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

        {
            "<leader>gd",
            function()
                if not vim.wo.diff then
                    vim.cmd("Gvdiffsplit!")
                    return
                end

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
                    local escaped_msg = input:gsub('"', '\\"')
                    vim.cmd('Git commit -m "' .. escaped_msg .. '"')
                end)
            end,
            desc = "Git Commit"
        },
        { "<leader>gp", "<cmd>Git push<cr>", desc = "Git Push" },
        { "<leader>gP", "<cmd>Git pull<cr>", desc = "Git Pull" },
    },
}
