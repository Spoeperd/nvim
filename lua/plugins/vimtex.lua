return {
    "lervag/vimtex",
    lazy = false,  -- Don't lazy load since we want to load on startup for .tex files
    ft = { "tex" },  -- Load only for tex files
    config = function()
        -- Set PDF viewer (choose one based on your macOS setup)
        vim.g.vimtex_view_method = "skim"  -- or "zathura" or "sioyek"

        -- Compiler settings
        vim.g.vimtex_compiler_method = "latexmk"

        -- Enable quickfix auto-open on warnings/errors
        vim.g.vimtex_quickfix_mode = 1

        -- Disable some unnecessary features for performance
        vim.g.vimtex_compiler_progname = "nvim"

        -- Enable folding (optional)
        vim.g.vimtex_fold_enabled = 0

        -- Keybindings (optional, vimtex has defaults with <localleader>)
        vim.keymap.set("n", "<leader>lc", "<cmd>VimtexCompile<CR>", { desc = "VimTeX: Compile" })
        vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { desc = "VimTeX: View PDF" })
        vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<CR>", { desc = "VimTeX: Toggle TOC" })
        vim.keymap.set("n", "<leader>lk", "<cmd>VimtexStop<CR>", { desc = "VimTeX: Stop compilation" })
        vim.keymap.set("n", "<leader>le", "<cmd>VimtexErrors<CR>", { desc = "VimTeX: Show errors" })
    end,
}
