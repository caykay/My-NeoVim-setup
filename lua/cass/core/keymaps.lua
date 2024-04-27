vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

-- keymap.set("i", "jk", "<ESC>")

keymap.set("n", "<leader>nh", ":nohl<CR>") -- clear search highlights

keymap.set("n", "x", '"_x') -- when deleting a character do not copy

keymap.set("n", "<leader>+", "<C-a>") -- increment numbers
keymap.set("n", "<leader>-", "<C-x>") -- decrement numbers

keymap.set("n", "<leader>aa", "gg<S-v>G") -- Select all text in a file

keymap.set("n", "<leader>oo", "o<ESC>") -- add new line after current line wihout entering insert mode
keymap.set("n", "<leader>O", "O<ESC>") -- add new line before current line wihout entering insert mode

-- Note:  <CR> means <Enter>

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<C-n>", "<C-w>w") -- move to next open window (Somehow this enables the use of <ESC> to move thru next active window too)

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- plugin keymaps

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type (ripgrep has to be installed "brew install ripgrep")
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- remap luasnip jump maps since they've been overriden with bufferline keymaps
-- ! for some reason the following does not work, or maybe i misunderstood the plugin's purpose
-- keymap.set("n", "<C-p>", "<Plug>luasnip-jump-prev")
-- keymap.set("n", "<C-n>", "<Plug>luasnip-jump-next")
-- keymap.set("n", "<C-e>", "<Plug>luasnip-expand-snippet")
