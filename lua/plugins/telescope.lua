return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Telescope: find files" },
		{ "<C-p>",      "<cmd>Telescope git_files<cr>",  desc = "Telescope: git files" },
		{ "<leader>ps", function()
			require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
		end, desc = "Telescope: grep prompt" },
	},
	opts = {}
}
