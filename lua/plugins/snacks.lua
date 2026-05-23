return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = {
            enabled = true,
            sources = {
                explorer = {
                    focus = "list",
                    auto_close = true,
                }
            }
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        dashboard = { enabled = true },
        notifier = { enabled = true },
        words = { enabled = true },
    },
    keys = {
        { "<leader>pf", function() Snacks.picker.files() end,                desc = "Snacks: Find Files" },
        { "<leader>ps", function() Snacks.picker.grep() end,                 desc = "Snacks: Live Grep" },
        { "<leader>pe", function() Snacks.explorer() end,                    desc = "Snacks: Explorer" },
        { "<leader>pd", function() Snacks.explorer({ focus = "input" }) end, desc = "Snacks: Find Directories" },

        { "<leader>gs", function() Snacks.lazygit() end,                     desc = "Git: Toggle Status & Panel (LazyGit)" },
        { "<leader>gb", function() Snacks.git.blame_line() end,              desc = "Git: Blame Line (Inline Virtual Text)" },
        { "<leader>gd", function() Snacks.picker.git_diff() end,             desc = "Git: View File Diff Changes" },
        { "<leader>gl", function() Snacks.picker.git_log() end,              desc = "Git: View Commit Log History" },
    },
}
