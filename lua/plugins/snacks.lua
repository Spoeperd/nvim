return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        picker = { enabled = true },
        explorer = {
            enabled = true,
            focus = "list",
            auto_close = true,
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
        { "<leader>pd", function() Snacks.explorer({ focus = "input" }) end, desc = "Snacks: Find Directories" }
    },
}
