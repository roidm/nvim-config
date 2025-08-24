return {

	{
		"catgoose/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	},

	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	"szw/vim-maximizer",
	keys = {
		{ "<leader>sm", "<cmd>MaximizerToggle<CR>", desc = "Maximize/minimize a split" },
	},
	{
		"HakonHarnes/img-clip.nvim",
		event = "VeryLazy",
		opts = {
			default = {

				use_absolute_path = false, ---@type boolean
				relative_to_current_file = true, ---@type boolean

				dir_path = vim.g.neovim_mode == "skitty" and "img" or function()
					return vim.fn.expand("%:t:r") .. "-img"
				end,

				prompt_for_file_name = false, ---@type boolean
				file_name = "%y%m%d-%H%M%S", ---@type string

				extension = "avif", ---@type string
				process_cmd = "convert - -quality 75 avif:-", ---@type string
			},
		},
		keys = {
			-- suggested keymap
			{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
		},
	},

	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			file = {
				[".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
				["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
			},
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},

	{
		{ "darfink/vim-plist" },
	},

	{
		"iamcco/markdown-preview.nvim",
		keys = {
			{
				"<leader>mp",
				ft = "markdown",
				"<cmd>MarkdownPreviewToggle<cr>",
				desc = "Markdown Preview",
			},
		},
		init = function()
			-- The default filename is 「${name}」and I just hate those symbols
			vim.g.mkdp_page_title = "${name}"
		end,
	},

	{
		"bullets-vim/bullets.vim",
		config = function()
			vim.g.bullets_delete_last_bullet_if_empty = 2

			-- vim.g.bullets_set_mappings = 1
		end,
	},
}
