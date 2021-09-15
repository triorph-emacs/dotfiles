local present, _ = pcall(require, "packerInit")
local packer

if present then
	packer = require("packer")
else
	return false
end

local use = packer.use
return packer.startup(function()
	-- Packer can manage itself
	use("wbthomason/packer.nvim") -- manage plugins

	-- git integration
	use({
		"tveskag/nvim-blame-line",
		config = function()
			vim.cmd([[autocmd BufEnter * EnableBlameLine]])
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()
		end,
	})

	-- Code formatting and linting
	use({ "neomake/neomake" }) -- used for pylama (is this still working?)
	use({ -- autoformat your code on save
		"lukas-reineke/format.nvim",
		config = function()
			require("config/format")
		end,
	})

	-- Language Server Processing(?)
	use({ -- better LSP handling, and setup configs
		"glepnir/lspsaga.nvim",
		requires = { "neovim/nvim-lspconfig" },
		config = function()
			require("config/lsp")
		end,
	})
	use({ "kosayoda/nvim-lightbulb" }) -- puts lightbulbs when a code action is available
	use({ -- takes care of showing LSP problems at the bottom of the screen
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("config/trouble")
		end,
	})

	-- Tab headers
	use({
		"akinsho/nvim-bufferline.lua",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("config/bufferline")
		end,
	})

	-- statusline at the bottom of the screen
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
		config = function()
			require("config/lualine")
		end,
	})

	--filetree
	use({
		"ms-jpq/chadtree",
		branch = "chad",
		config = function()
			require("config/chadtree")
		end,
	})

	-- Fuzzy search/file find
	use({ -- awesome plugin that lets you open a window to fuzzy-find things
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = function()
			require("telescope").load_extension("mapper")
			require("telescope").load_extension("neoclip")
		end,
	})
	use({ -- see your keymappings in telescope
		"lazytanuki/nvim-mapper",
		config = function()
			require("nvim-mapper").setup({})
		end,
		before = "telescope.nvim",
	})
	-- Copy/Paste
	use({ -- store all yanks and allow you to open up a history in telescope
		"AckslD/nvim-neoclip.lua",
		config = function()
			require("neoclip").setup()
		end,
		before = "telescope.nvim",
	})

	-- Autocompletion
	use({ -- super fast autocomplete
		"ms-jpq/coq_nvim",
		branch = "coq",
		requires = { { "ms-jpq/coq.artifacts", branch = "artifacts" } },
		config = function()
			require("config/autocomplete")
		end,
	})

	-- Comments
	use("b3nj5m1n/kommentary") -- autocommenting of code

	-- help
	use({ -- after a pause, bring up a popup that shows what commands you have available after pressing a key
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})

	-- Highlight code
	use({ -- treesitter - better highlighting of variables
		"nvim-treesitter/nvim-treesitter",
		run = function()
			vim.cmd([[:TSUpdate]])
		end,
		config = function()
			require("config/treesitter")
		end,
	})
	use({ -- show indentation levels
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config/indent")
		end,
	})
	use({ "mechatroner/rainbow_csv" }) -- syntax highlighting of columns for CSV files

	-- Look pretty
	use({ -- dashboard
		"goolord/alpha-nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config/dashboard")
		end,
	})
	use({ -- only show colour for what's active
		"folke/twilight.nvim",
		config = function()
			require("twilight").setup({})
		end,
	})
	use({ -- F11 to go all in on focus
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({
				plugins = { tmux = { enabled = true } },
			})
		end,
	})
	use({ -- fibonacci window splitting (doesn't interact well with bufferline though)
		"beauwilliams/focus.nvim",
		config = function()
			require("focus").setup()
		end,
	})
	use({ -- smooth scrolling
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup({
				mappings = { "<C-u>", "<C-d>" },
			})
			local t = {}
			t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "100" } }
			t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "100" } }
			require("neoscroll.config").set_mappings(t)
		end,
	})

	-- colour schemes
	use({
		"folke/tokyonight.nvim",
		config = function()
			require("config/colour")
		end,
	})
	use({ "EdenEast/nightfox.nvim" })
	use({ "Pocco81/Catppuccino.nvim" })
	use({ "morhetz/gruvbox" })

	-- Misc utils
	use({ "npxbr/glow.nvim", run = "GlowInstall" }) -- markdown preview
	use({ "tpope/vim-surround" }) -- the ability to edit surrounding things, like quotes or brackets
	use({ "wellle/targets.vim" }) -- more text objects, like "inside argument"
	use({ -- alternative to EasyMotion or Sneak for faster movement
		"ggandor/lightspeed.nvim",
		config = function()
			require("lightspeed").setup({
				instant_repeat_fwd_key = ";",
				instant_repeat_bwd_key = ",",
			})
		end,
	})
	use({ -- faster caching, and profile your plugins
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient").enable_profile()
		end,
	})
	--[[ use({ -- disable repeatedly hjkl keys, to force you to get used to other options.
		"takac/vim-hardtime",
		config = function()
			vim.g.hardtime_default_on = 0
		end,
	}) ]]
	use({ "andymass/vim-matchup", event = "VimEnter" })
	use({ "ThePrimeagen/vim-be-good" })
end)
