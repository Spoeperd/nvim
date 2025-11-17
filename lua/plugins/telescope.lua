return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Telescope: find files" },
		{ "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Telescope: git files" },
        { "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Telescope: live grep" },
    },
}
