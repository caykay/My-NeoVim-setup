local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = "thick",
		always_show_bufferline = false,
		show_buffer_close_icons = false,
		show_close_icon = false,
		color_icons = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = function()
					return vim.fn.substitute(vim.fn.getcwd(), "^.*/", "", "")
				end,
				highlight = "Directory",
				separator = true, -- use a "true" to enable the default, or set your own character
				text_align = "left",
			},
		},
	},
	highlights = {
		separator = {
			fg = "#073642",
			bg = "#002b36",
		},
		separator_selected = {
			fg = "#073642",
		},
		background = {
			fg = "#657b83",
			bg = "#002b36",
		},
		buffer_selected = {
			fg = "#fdf6e3",
			bold = true,
		},
		fill = {
			bg = "#073642",
		},
	},
})

local keymap = vim.keymap -- for conciseness

keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>")
keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>")
