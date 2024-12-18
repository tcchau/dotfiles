return {
	"nvim-telescope/telescope.nvim",
	opts = function(_, opts)
		opts.defaults = vim.tbl_extend("force", opts.defaults or {}, {
			sorting_strategy = "ascending",
			layout_config = { prompt_position = "top" },
		})

		opts.pickers = vim.tbl_extend("force", opts.pickers or {}, {
			buffers = {
				sort_mru = true,
				ignore_current_buffer = true,
				sort_lastused = true,
			},
		})
	end,
}
