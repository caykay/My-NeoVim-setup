-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- autocommand that clears background before colorscheme is selected
vim.cmd([[
  augroup user_colors
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
  augroup END
]])

-- install packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	-- lua functions that many plugins use
	-- this plugin has some  useful functions
	-- see utils/file.lua for an example
	use("nvim-lua/plenary.nvim")

	use("bluz71/vim-nightfly-guicolors") -- preffered color scheme

	-- tmux & split window navigation
	use("christoomey/vim-tmux-navigator") -- <C-j> and <C-k> to move btn horizontal-separated windows | <C-h> and <C-l> to move btn verically-separated windows

	use("szw/vim-maximizer")

	use("akinsho/bufferline.nvim") -- Bufferline for tabpage integration

	-- essential plugins
	use("tpope/vim-surround") -- allows to add/delete/update/etc... a surrounding/clause symbol between text/word/statement/code: ys<motion>'symbol'
	use("vim-scripts/ReplaceWithRegister") -- replace content with other content (ie. clipboard): gr<motion>

	-- commenting with gc
	use("numToStr/Comment.nvim") -- can comment lines with "gc" or "gc'#'j" or "gc'#'k"

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- icons (with vscode like icons)
	use("kyazdani42/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- managing and insatalling lsp servers
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- git.nvim for common Git commands within neovim
	use({
		"dinhhuy258/git.nvim",
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- plugging to enable debugging (primarily did this for c++, not sure if works with other languages)
	use("mfussenegger/nvim-dap")

	-- bridges the gap between mason.nvim and nvim-dap
	use({
		"jay-babu/mason-nvim-dap.nvim",
		branch = "main",
		requires = {
			{ "williamboman/mason.nvim" },
			{ "mfussenegger/nvim-dap" },
		},
	})

	-- ui plugin for nvim-dab
	use({
		"rcarriga/nvim-dap-ui",
		requires = {
			{ "mfussenegger/nvim-dap" },
			{ "nvim-neotest/nvim-nio" },
		},
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
